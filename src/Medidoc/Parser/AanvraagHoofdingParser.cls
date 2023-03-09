Class Medidoc.Parser.AanvraagHoofdingParser [ Abstract ]
{

ClassMethod parseAanvraagHoofding(aStream As %FileCharacterStream, Output pResult As Medidoc.AanvraagHoofding) As %Status
{
	set st = $$$OK

	set pResult =  ##class(Medidoc.AanvraagHoofding).%New()
	
	set line=$zstrip(aStream.ReadLine(),"<>W")
	if ("#" =$piece(line,"/",1)){
		return st
	}
	if ($length(line)>50){  
		set st = $$$ERROR($$$GeneralError,"Pid niet conform medidoc standaard")
		quit st
	}
	Set pResult.Pid = $extract(line,3,50)
	
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	
	if ($length(line)>40){ 
		set st = $$$ERROR($$$GeneralError,"naam en voornaam patient")
		quit st
	}
	Set pResult.AchterNaamPatient = $extract(line,0,24)
	Set pResult.VoornaamPatient = $extract(line,25,40)
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){  
		set st = $$$ERROR($$$GeneralError,"geboortedatum patient niet conform medidoc standaard")
		quit st
	}
	Set pResult.geboortedatumPatient = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){  
		set st = $$$ERROR($$$GeneralError,"geslacht patient niet conform medidoc standaard")
		quit st
	}
	set pResult.geslachtPatient=line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){  
		set st = $$$ERROR($$$GeneralError,"datum van de aanvraag niet conform medidoc standaard")
		quit st
	}
	Set pResult.datumVanDeAanvraag = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){  
		set st = $$$ERROR($$$GeneralError,"referentienummer van de aanvraag niet conform medidoc standaard")
		quit st
	}
	Set pResult.ReferentieNummerVanDeAanvraag = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>1){  
		set st = $$$ERROR($$$GeneralError,"protocol code "_line_" niet conform medidoc standaard")
		quit st
	}
	Set pResult.protocolCode = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){  
		set st = $$$ERROR($$$GeneralError,"patient straatnaam en adres niet conform medidoc standaard")
		quit st
	}	
	Set pResult.straatnaamEnHuisnummerPatient = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){  
		set st = $$$ERROR($$$GeneralError,"patient postcode niet conform medidoc standaard")
		quit st
	}
	Set pResult.postcodePatient = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){  
		set st = $$$ERROR($$$GeneralError,"patient stad niet conform medidoc standaard")
		quit st
	}
	Set pResult.woonplaatsPatient = line
	
	set st = ##class(Medidoc.Parser.UitslagParser).parseUitslagen(.aStream,.uitslagen)
	set pResult.uitslagen = uitslagen 

	return st
}

}
