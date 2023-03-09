Class Medidoc.ConversionTable Extends %Persistent
{

Property MedidocCode As %String(MAXLEN = 10);

Property LoincCode As %String(MAXLEN = 10);

Property Description As %String(MAXLEN = 100000);

Index OnMC On MedidocCode;

Storage Default
{
<Data name="ConversionTableDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>MedidocCode</Value>
</Value>
<Value name="3">
<Value>LoincCode</Value>
</Value>
<Value name="4">
<Value>Description</Value>
</Value>
</Data>
<DataLocation>^Medidoc.ConversionTableD</DataLocation>
<DefaultData>ConversionTableDefaultData</DefaultData>
<IdLocation>^Medidoc.ConversionTableD</IdLocation>
<IndexLocation>^Medidoc.ConversionTableI</IndexLocation>
<StreamLocation>^Medidoc.ConversionTableS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
