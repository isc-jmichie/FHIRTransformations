Class Medidoc.Request Extends Ens.Request
{

Property MedidocPerPatient As Medidoc.MedidocPerPatient;

Storage Default
{
<Data name="RequestDefaultData">
<Subscript>"Request"</Subscript>
<Value name="1">
<Value>MedidocPerPatient</Value>
</Value>
<Value name="2">
<Value>MedidocCodesInventaris</Value>
</Value>
</Data>
<DefaultData>RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
