/// Hier kun je de documentatie kwijt. <br> <var>naam van variabele</var>
Class Medidoc.Uitslag Extends (%Persistent, %XML.Adaptor)
{

// internal keyword wordt gebruikt om de property uit de documentatie te weren

Property uitslagType As %String(MAXLEN = 1);

Property analyseID As %String(MAXLEN = 57) [ Internal ];

Property uitslag As %String(MAXLEN = 77);

Property eenheidID As %String(MAXLEN = 30);

Property aanduidingPathologischNormaal As %String(MAXLEN = 2);

Property referenceRange As %String(MAXLEN = 75);

Property relativeTime As %Integer;

// een lijst van commentaarlijnen

Property commentaarlijnen As list Of %String(MAXLEN = 75);

Method toString() As %String
{
	set newline = $CHAR(13,10)
	
	set result = "Uitslag type "_ ..uitslagType  _ newline
	set result = result _ "waarde: " _ ..uitslag _", eenheidscode: " _ ..eenheidID _ newline
	set result = result _ "pathologisch normaal: " _ ..aanduidingPathologischNormaal _ ", referentiebereik: " _ ..referenceRange _ newline
	set len = ..commentaarlijnen.Count()
	for i=1:1:len {
		set result = result _ ..commentaarlijnen.GetAt(i) _newline
	}
	return result
}

Method print()
{
	w ..toString()
}

Storage Default
{
<Data name="UitslagDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>uitslagType</Value>
</Value>
<Value name="3">
<Value>analyseID</Value>
</Value>
<Value name="4">
<Value>uitslag</Value>
</Value>
<Value name="5">
<Value>eenheidID</Value>
</Value>
<Value name="6">
<Value>aanduidingPathologischNormaal</Value>
</Value>
<Value name="7">
<Value>referenceRange</Value>
</Value>
<Value name="8">
<Value>commentaarlijnen</Value>
</Value>
<Value name="9">
<Value>relativeTime</Value>
</Value>
</Data>
<DataLocation>^Medidoc.UitslagD</DataLocation>
<DefaultData>UitslagDefaultData</DefaultData>
<IdLocation>^Medidoc.UitslagD</IdLocation>
<IndexLocation>^Medidoc.UitslagI</IndexLocation>
<StreamLocation>^Medidoc.UitslagS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
