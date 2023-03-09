Class Medidoc.Parser.MedidocParser Extends %RegisteredObject
{

Parameter BEGINAANVRAAGHOOFDING = "#A";

Parameter BEGINAANUITSLAGA = "#Ra";

Parameter BEGINAANUITSLAGB = "#Rb";

Parameter BEGINAANUITSLAGC = "#Rc";

ClassMethod parseMedidoc(FileName As %String) As %Status
{
	 
	w "parsing medidoc " _ FileName
	try {
	  	set tStream = ##class(%FileCharacterStream).%New()
	  	set tStream.Filename=FileName

		// parse exact 1 bestandshoofding
		set st = ##class(Medidoc.Parser.BestandsHoofdingParser).parseBestandsHoofding(.tStream,.bestandshoofding)
	
	
	  	// parse 1 of meerdere AanvraagHoofdingen
	  	Set line=""
	
      	while (1) {
			set st =  ##class(Medidoc.Parser.AanvraagHoofdingParser).parseAanvraagHoofding(.tStream,.aanvraaghoofding)
		
			// zonder ingevulde aanvraag hoofding stoppen we
			if ( aanvraaghoofding.isEmpty()) {
			return st
		} 	
	
		set tMedidoc = ##class(Medidoc.Request).%New()
		set tMedidocPerPatient = ##class(Medidoc.MedidocPerPatient).%New()
		
		
		set tMedidocPerPatient.Bestandshoofding = bestandshoofding
		set tMedidocPerPatient.AanvraagHoofding = aanvraaghoofding
      }
	  
     } 
     catch errobj {}
	quit $$$OK
}

}
