Class Medidoc.impl Extends %REST.Impl
{

ClassMethod MedidocToFileService(stream As %Stream.Object) As %Stream.Object
{
    
    set sc = ##class(Ens.Director).CreateBusinessService("MedidocFileService", .tHandleMedidocService)
    if $$$ISERR(sc) 
    { 
        do ..%SetStatusCode(503)
        set pOutput = {
            "503":
            {
                "Description": "Service unavailable"
            }
        }
        return pOutput
    }

    set sc = tHandleMedidocService.ProcessInput(stream, .pResponse)
    if $$$ISERR(sc) 
    { 
        do ..%SetStatusCode(503)
        set pOutput = {
            "503":
            {
                "Description": "Service unavailable"
            }
        }
        return pOutput
    }

    if (pResponse = "Some results are missing due to missing mapping between MedidocCode and LoincCode")
    { 
        do ..%SetStatusCode(503)
        set pOutput = {
            "503":
            {
                "Description": "Some results are missing due to missing mapping between MedidocCode and LoincCode"
            }
        }
        return pOutput
    }

    do ..%SetStatusCode(200)
    return pResponse
}

}
