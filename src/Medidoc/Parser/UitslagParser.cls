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
		if ($e(line,1,2) = "#R"){
			set type = $extract(line,3)	
			//w "type uitslag ", type, !
			set st = ..parseUitslag(aStream, type, .uitslag) 
			if (st = $$$OK){
				do aUitslagen.Uitslagen.Insert(uitslag)
			}
		}
		// Read until ending
		else {
			return st
		}
	}
	
	return st
}

ClassMethod parseUitslag(aStream As %FileCharacterStream, uitslagType As %String, Output aUitslag As Medidoc.Uitslag) As %Status
{
	set st = $$$OK

	set aUitslag =  ##class(Medidoc.Uitslag).%New()
	set aUitslag.uitslagType = uitslagType
	set line = $zstrip(aStream.ReadLine(),"<>W")
	set aUitslag.analyseID = $piece(line,"/",1)
	set aUitslag.relativeTime = $piece(line,"/",2)
	
	//opgelet tussen if en '(' altijd exact 1 spatie plaatsen
	if ((uitslagType = "a" ) || (uitslagType = "d" ) || (uitslagType = "h" ) || (uitslagType = "m" ) || (uitslagType = "s" ))
	{	
		set aUitslag.uitslag = $zstrip(aStream.ReadLine(),"<>W")
		set aUitslag.uitslag = $case($e(aUitslag.uitslag,1),"=":$e(aUitslag.uitslag,2,*),:aUitslag.uitslag)
		set aUitslag.eenheidID = $zstrip(aStream.ReadLine(),"<>W")
		set aPN = $zstrip(aStream.ReadLine(),"<>W")
		if ((aPN = "--") || (aPN = "LL") || (aPN = "1")){
			set aUitslag.aanduidingPathologischNormaal = "LL"
		}
		if ((aPN = "-") || (aPN = "L") || (aPN = "2")){
			set aUitslag.aanduidingPathologischNormaal = "L"
		}
		if ((aPN = "=") || (aPN = "N") || (aPN = "3") || (aPN = "")){
			set aUitslag.aanduidingPathologischNormaal = "N"
		}
		if ((aPN = "+") || (aPN = "H") || (aPN = "4")){
			set aUitslag.aanduidingPathologischNormaal = "H"
		}
		if ((aPN = "++") || (aPN = "HH") || (aPN = "5")){
			set aUitslag.aanduidingPathologischNormaal = "HH"
		}
		
		
	}

	if (uitslagType = "b"){
		set line = $zstrip(aStream.ReadLine(),"<>W")
		set aUitslag.uitslag = ""
		while (line '= "#R/") {
			if aUitslag.uitslag = "" {
				set aUitslag.uitslag = aUitslag.uitslag_line
			} else {
				set aUitslag.uitslag = aUitslag.uitslag_", "_line
			}
			set line = $zstrip(aStream.ReadLine(),"<>W")
		}
		return st
	}
	
	
	set line = $zstrip(aStream.ReadLine(),"<>W")
	while (line '= "#R/") {
		
		// if the line starts with '\' it means it is a reference range
		// remove the '\' out of the string
		set tempReference = $e(line, 1)
		if (tempReference = "\")
		{
			set aUitslag.referenceRange = $e(line,2,*)
		}
		else 
		{
			if aUitslag.commentaarlijnen = ""
			{
				set aUitslag.commentaarlijnen = line
			}
			else {
				set aUitslag.commentaarlijnen = aUitslag.commentaarlijnen_", "_line
			}
			
		
		}
		set line = $zstrip(aStream.ReadLine(),"<>W")
	}

	return st
}

}
