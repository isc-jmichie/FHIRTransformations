Class Medidoc.ImportCSV
{

ClassMethod ImportCSV() As %Status
{
        set totalinserted = 0
        set total = 0
        set totalbytes = 0
        set count = 0
        set mgr = ##class(%SQL.Import.Mgr).%New()
        Set mobj = ##class(%SQL.Manager.API).%New()
        Set mgr.FileName = "/opt/irisapp/misc/MedidocLoinc.csv"
        Set mgr.TableName = "Medidoc.ConversionTable"
        Set mgr.ClassName = mobj.FindClassName("Medidoc.ConversionTable")
        Set mgr.Delimiter = ","
        Set mgr.HasHeaders = 1
        Set mgr.NoCheck = 1
        Set mgr.IQN=$$$BuildIQN("Medidoc","ConversionTable")
        Do mgr.ColumnNames.Insert("MedidocCode")
        Do mgr.ColumnNames.Insert("LoincCode")
        Do mgr.ColumnNames.Insert("Description")
        Do mgr.ColumnTypes.Insert("S")
        Do mgr.ColumnTypes.Insert("S")
        Do mgr.ColumnTypes.Insert("S")
        Set mgr.DeferIndices = 1
	    Set result = mgr.GenerateImportRoutine()
	    If result '= 1 { Write !,"Error generating import routine: ",result return "Error" }
	    Set sta = mgr.OpenImport()
	    If $$$ISERR(sta) {
		    Set ErrMsg = "Unable to open import file"
            return sta
    	} Else {
	    	If mgr.HasHeaders = 1 { Set sta = mgr.ReadHeader(.header,.size) }
		    Set tSC = $$$OK
		    Do {
			    Set tSC = mgr.ImportRows(.count,.inserted,.bytes,.done,.numerr,total)
                Set total = total + count
			    Set totalinserted = totalinserted + inserted
			    Set totalbytes = totalbytes + bytes
			    If $$$ISERR(tSC) w "Error fatal",! return tSC
		    } While done = 0
		    Do mgr.BuildIndices()
		    If mgr.ErrorCount() > 0 {
			    w mgr.ErrorCount()
		    } Else {
			    If $$$ISOK(tSC) {
				    Set tmsg = "Completed at "_$zdt($h)
    			} Else {
	    			Set tmsg ="Error occurred during import."
                    return tSC
		    	}
			    Set statusmsg = "Imported: "_totalinserted_" rows"
    			Write !,tmsg,!,statusmsg
	    	}
		    Do mgr.CloseImport(0)
	    }
	    Do mgr.DeleteImportRoutine()
        return tSC
}

}
