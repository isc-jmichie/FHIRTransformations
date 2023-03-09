Class Medidoc.Uitslagen Extends (%SerialObject, %XML.Adaptor)
{

Property Uitslagen As list Of Medidoc.Uitslag;

Method print() As %Status
{
	w "===========Uitslagen =================",!
	set len = ..Uitslagen.Count()
	w "aantal uitslagen:",len,!
	for i=1:1:len {
		do ..Uitslagen.GetAt(i).print()
	}
	w "================================================",!
	quit $$$OK
}

Storage Default
{
<Data name="UitslagenState">
<Value name="1">
<Value>Uitslagen</Value>
</Value>
</Data>
<State>UitslagenState</State>
<StreamLocation>^Medidoc.UitslagenS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
