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
	
	set analyseIDFirstChar = $extract(aUitslag.analyseID)
	if (analyseIDFirstChar '= "!")
	{
		set analyseCode = aUitslag.analyseID
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
