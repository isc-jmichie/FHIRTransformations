Class Medidoc.FHIRResponse Extends (Ens.Response, %JSON.Adaptor, %XML.Adaptor)
{

Property body As %Stream.GlobalCharacter;

Property error As %String(MAXLEN = 1000);

Storage Default
{
<Data name="FHIRResponseDefaultData">
<Subscript>"FHIRResponse"</Subscript>
<Value name="1">
<Value>body</Value>
</Value>
<Value name="2">
<Value>error</Value>
</Value>
</Data>
<DefaultData>FHIRResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
