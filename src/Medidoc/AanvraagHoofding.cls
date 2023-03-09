Class Medidoc.AanvraagHoofding Extends (%Persistent, %XML.Adaptor)
{

Property Pid As %String(MAXLEN = 50);

Property AchterNaamPatient As %String(MAXLEN = 24);

Property VoornaamPatient As %String(MAXLEN = 16);

Property geboortedatumPatient As %String(MAXLEN = 16);

Property geslachtPatient As %String(MAXLEN = 1);

Property datumVanDeAanvraag As %String(MAXLEN = 16);

Property ReferentieNummerVanDeAanvraag As %String(MAXLEN = 14);

Property protocolCode As %String(MAXLEN = 1);

Property straatnaamEnHuisnummerPatient As %String(MAXLEN = 31);

Property postcodePatient As %String(MAXLEN = 7);

Property woonplaatsPatient As %String(MAXLEN = 24);

Property uitslagen As Medidoc.Uitslagen;

Method print() As %Status
{
	w "===========Aanduiding Aanvraag =================",!
	write "Aanduiding Aanvraag:", ..Pid,!
	write "Patient Achternaam:", ..AchterNaamPatient,!
	write "Patient Voornaam:", ..VoornaamPatient,!
	write "Patient Geboortedatum:", ..geboortedatumPatient,!
	write "Patient geslacht:", ..geslachtPatient,!
	write "Patient datum van de aanvraag:", ..datumVanDeAanvraag,!
	write "Patient referentienummer van de aanvraag:", ..ReferentieNummerVanDeAanvraag,!
	write "Protocol code:", ..protocolCode,!
	write "Patient straat en nr:", ..straatnaamEnHuisnummerPatient,!
	write "Patient postcode:", ..postcodePatient,!
	write "Patient stad:", ..woonplaatsPatient,!
	write ..uitslagen.print(),!
	w "================================================",!
	quit $$$OK
}

Method isEmpty() As %Boolean
{
	if (..geslachtPatient = "") return 1
	return 0
}

Storage Default
{
<Data name="AanvraagHoofdingDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Pid</Value>
</Value>
<Value name="3">
<Value>AchterNaamPatient</Value>
</Value>
<Value name="4">
<Value>VoornaamPatient</Value>
</Value>
<Value name="5">
<Value>geboortedatumPatient</Value>
</Value>
<Value name="6">
<Value>geslachtPatient</Value>
</Value>
<Value name="7">
<Value>datumVanDeAanvraag</Value>
</Value>
<Value name="8">
<Value>ReferentieNummerVanDeAanvraag</Value>
</Value>
<Value name="9">
<Value>protocolCode</Value>
</Value>
<Value name="10">
<Value>straatnaamEnHuisnummerPatient</Value>
</Value>
<Value name="11">
<Value>postcodePatient</Value>
</Value>
<Value name="12">
<Value>woonplaatsPatient</Value>
</Value>
<Value name="13">
<Value>uitslagen</Value>
</Value>
</Data>
<DataLocation>^Medidoc.AanvraagHoofdingD</DataLocation>
<DefaultData>AanvraagHoofdingDefaultData</DefaultData>
<IdLocation>^Medidoc.AanvraagHoofdingD</IdLocation>
<IndexLocation>^Medidoc.AanvraagHoofdingI</IndexLocation>
<StreamLocation>^Medidoc.AanvraagHoofdingS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
