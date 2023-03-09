Class Medidoc.MedidocPerPatient Extends (%Persistent, %XML.Adaptor)
{

Property Bestandshoofding As Medidoc.BestandsHoofding;

Property AanvraagHoofding As Medidoc.AanvraagHoofding;

Storage Default
{
<Data name="MedidocPerPatientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Bestandshoofding</Value>
</Value>
<Value name="3">
<Value>AanvraagHoofding</Value>
</Value>
</Data>
<DataLocation>^Medidoc.MedidocPerPatientD</DataLocation>
<DefaultData>MedidocPerPatientDefaultData</DefaultData>
<IdLocation>^Medidoc.MedidocPerPatientD</IdLocation>
<IndexLocation>^Medidoc.MedidocPerPatientI</IndexLocation>
<StreamLocation>^Medidoc.MedidocPerPatientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
