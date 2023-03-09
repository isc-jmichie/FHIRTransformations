Class Medidoc.Parser.UitslagParser [ Abstract ]
{

ClassMethod parseUitslagen(aStream As %FileCharacterStream, Output aUitslagen As Medidoc.Uitslagen) As %Status
{
	set st = $$$OK
	set aUitslagen = ##class(Medidoc.Uitslagen).%New()
	Set line=""
	//TODO check op basis van status
	while (line '= "#A/") {
		//w "looping analyses: ", line,!
		set line = $zstrip(aStream.ReadLine(),"<>W")
		//w "eerste analyselijn: ", line,!
		if (line = "#A/") {
			return st 
		}
		set type = $extract(line,3)	
		//w "type uitslag ", type, !
		set st = ..parseUitslag(aStream, type, .uitslag) 
		if (st = $$$OK){
			do aUitslagen.Uitslagen.Insert(uitslag)
		} 	
	}
	
	return st
}

ClassMethod parseUitslag(aStream As %FileCharacterStream, uitslagType As %String, Output aUitslag As Medidoc.Uitslag) As %Status
{
	set st = $$$OK

	set aUitslag =  ##class(Medidoc.Uitslag).%New()
	set aUitslag.uitslagType = uitslagType
	set aUitslag.analyseID = $zstrip(aStream.ReadLine(),"<>W") 
	
	// als de analyseID niet met een ! begint is het een medidoccode. Voor het programma van Medidoc
	// moeten we garanderen dat alle medidoccodes exact 10 karakters zijn
	// als de analyseID minder dan 10 karakters is voegen we extra karakters toe
	// voorbeelden
	//   "!eentest" => "!eentest"
	//   "0100...." => "0100....01"
	//   "13913_.A" => "13913_.A01"
	set analyseIDFirstChar = $extract(aUitslag.analyseID)
	if (analyseIDFirstChar '= "!")
	{
		set analyseCode = aUitslag.analyseID
		if ($LENGTH(analyseCode) < 8 || $LENGTH(analyseCode) = 9 || $LENGTH(analyseCode) >10)
		{
			// volgens de standaard moet een code 8 of 10 karakters zijn, om de fout te kunnen tonen voor de eindgebruiker voegen
			// we deze info in de commentaarlijen toe
			do aUitslag.commentaarlijnen.Insert("ongeldige medidoc code van labo ontvangen, hierdoor kan de visualisatie foutief zijn: " _ analyseCode)
			do aUitslag.commentaarlijnen.Insert("Gelieve interne support te contacteren en te verwijzen naar dit bericht")
			
		}
		
	}
	
	//opgelet tussen if en '(' altijd exact 1 spatie plaatsen
	if (uitslagType = "a")
	{	
		set aUitslag.uitslag = $zstrip(aStream.ReadLine(),"<>W")
		set aUitslag.eenheidID = $zstrip(aStream.ReadLine(),"<>W")
		set aUitslag.aanduidingPathologischNormaal = $zstrip(aStream.ReadLine(),"<>W")
		
	}
	
	
	set line = $zstrip(aStream.ReadLine(),"<>W")
	while (line '= "#R/") {
		
		// if the line starts with '\' it means it is a reference range
		// remove the '\' out of the string
		set tempReference = $piece(line, "\", 2, 2)
		if ($length(tempReference)>0)
		{
			set aUitslag.referenceRange = tempReference
		}
		else 
		{
			do aUitslag.commentaarlijnen.Insert(line)
		
		}
		set line = $zstrip(aStream.ReadLine(),"<>W")
	}

	return st
}

}
