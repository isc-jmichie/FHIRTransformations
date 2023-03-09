/// This class creates a medidoc bestaandshoofding <br>
/// this exists out of one ore multiple aanvraaghoofdingen which exist out of one or multiple analyses 
Class Medidoc.BestandsHoofding Extends (%Persistent, %XML.Adaptor)
{

Property medidocCode As %String(MAXLEN = 11);

Property laboNaam As %String(MAXLEN = 50);

Property laboStraat As %String(MAXLEN = 50);

Property laboStad As %String(MAXLEN = 50);

Property laboContact As %String(MAXLEN = 50);

Property laboRiziv As %String(MAXLEN = 50);

Property aanmaakDatum As %String(MAXLEN = 16);

Property aanvragerRiziv As %String(MAXLEN = 14);

Property AanvragerVoornaam As %String(MAXLEN = 16);

Property AanvragerAchternaam As %String(MAXLEN = 24);

Method print()
{
	w "===========Bestands Hoofding =================",!
	write "medidocCode:",..medidocCode,!
	write "labo naam: ","|",..laboNaam,"|",!
	write "labo straat: ","|",..laboStraat,"|",$l(..laboStraat),!
	write "labo stad: ","|",..laboStad,"|",$l(..laboStad),!
	write "labo contact: ","|",..laboContact,"|",!
	write "labo riziv: ", "|",..laboRiziv,"|",!
	write "labo aanmaakdatum: ", "|",..aanmaakDatum,"|",!
	write "labo aanvragerRiziv ", "|",..aanvragerRiziv,"|",!
	write "labo aanvragerAchternaam: ", "|",..AanvragerAchternaam,"|",!
	write "labo aanvragerVoornaam ", "|",..AanvragerVoornaam,"|",!
	
	w "================================================",!
}

Storage Default
{
<Data name="BestandsHoofdingDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>medidocCode</Value>
</Value>
<Value name="3">
<Value>laboNaam</Value>
</Value>
<Value name="4">
<Value>laboStraat</Value>
</Value>
<Value name="5">
<Value>laboStad</Value>
</Value>
<Value name="6">
<Value>laboContact</Value>
</Value>
<Value name="7">
<Value>laboRiziv</Value>
</Value>
<Value name="8">
<Value>aanmaakDatum</Value>
</Value>
<Value name="9">
<Value>aanvragerRiziv</Value>
</Value>
<Value name="10">
<Value>AanvragerVoornaam</Value>
</Value>
<Value name="11">
<Value>AanvragerAchternaam</Value>
</Value>
</Data>
<DataLocation>^Medidoc.BestandsHoofdingD</DataLocation>
<DefaultData>BestandsHoofdingDefaultData</DefaultData>
<IdLocation>^Medidoc.BestandsHoofdingD</IdLocation>
<IndexLocation>^Medidoc.BestandsHoofdingI</IndexLocation>
<StreamLocation>^Medidoc.BestandsHoofdingS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
