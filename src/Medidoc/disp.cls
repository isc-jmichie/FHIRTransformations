Class Medidoc.disp Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/fhir" Method="POST" Call="MedidocToFileService" Cors="true" />
</Routes>
}

ClassMethod MedidocToFileService() As %Status
{
    Try {
        If $case(%request.ContentType,"text/plain":0,:1) Do ##class(%REST.Impl).%ReportRESTError(..#HTTP415UNSUPPORTEDMEDIATYPE,$$$ERROR($$$RESTContentType,%request.ContentType)) Quit
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        set medidocStream = %request.Content
        set string = $replace(medidocStream.Read(),$c(10),$c(13,10))
        set string = $replace(string, $c(13,13), $c(13))
        set stream=##class(%Stream.GlobalCharacter).%New()
        do stream.Write(string)
        Set response=##class(Medidoc.impl).MedidocToFileService(stream)
        Do ##class(%REST.Impl).%WriteResponse(response)
    }
    Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("500")
        return {"500": "Internal server error"}
    }
    Quit $$$OK
}

}
