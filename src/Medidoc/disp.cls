Class Medidoc.disp Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/fhir" Method="POST" Call="MedidocToFileService" />
</Routes>
}

ClassMethod MedidocToFileService() As %Status
{
    Try {
        If $case(%request.ContentType,"text/plain":0,:1) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType)) Quit
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        set medidocStream = %request.Content
        Set response=##class(Medidoc.impl).MedidocToFileService(medidocStream)
        Do ##class(%REST.Impl).%WriteResponse(response)
    }
    Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("500")
        return {"500": "Internal server error"}
    }
    Quit $$$OK
}

}
