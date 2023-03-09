Class Medidoc.Parser.BestandsHoofdingParser [ Abstract ]
{

ClassMethod parseBestandsHoofding(aStream As %FileCharacterStream, Output aBestandshoofding As Medidoc.BestandsHoofding) As %Status
{
	set st =$$$OK
	set aBestandshoofding =  ##class(Medidoc.BestandsHoofding).%New()
	Set line=aStream.ReadLine()

	//verwijder alle spaties voor en na 'betekenisvolle' karakters
	set line=$zstrip(line,"<>W")
	
	if (($length(line)>11) || ($length(line)<2)){ 
		set st = $$$ERROR($$$GeneralError,"Medidoc code niet conform medidoc standaard")
		quit st
	}
	Set aBestandshoofding.medidocCode=line

	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){ 
		set st = $$$ERROR($$$GeneralError,"Labonaam niet conform medidoc standaard")
		quit st
	}
	Set aBestandshoofding.laboNaam = line

	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){  
		set st = $$$ERROR($$$GeneralError,"LaboStraat en nummer niet conform medidoc standaard")
		quit st
	}
	Set aBestandshoofding.laboStraat = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){ 
		set st = $$$ERROR($$$GeneralError,"Labo Stad niet conform medidoc standaard")
		quit
	}
	Set aBestandshoofding.laboStad = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){ 
		set st = $$$ERROR($$$GeneralError,"Labo contact niet conform medidoc standaard")
		quit
	}
	Set aBestandshoofding.laboContact = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>50){ 
		set st = $$$ERROR($$$GeneralError,"Labo Riziv niet conform medidoc standaard")
		quit
	}
	Set aBestandshoofding.laboRiziv = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>12){ 
		set st = $$$ERROR($$$GeneralError,"Creatiedatum niet conform medidoc standaard")
		quit
	}
	Set aBestandshoofding.aanmaakDatum = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>14){ 
		set st = $$$ERROR($$$GeneralError,"Optioneel Riziv nummer aanvragende arts niet conform medidoc standaard")
		quit st
	}
	Set aBestandshoofding.aanvragerRiziv = line
	
	Set line=$zstrip(aStream.ReadLine(),"<>W")
	if ($length(line)>40){ 
		set st = $$$ERROR($$$GeneralError,"naam en voornaam aanvragende arts niet conform medidoc standaard")
		quit st
	}

	Set aBestandshoofding.AanvragerAchternaam = $extract(line,0,24)
	Set aBestandshoofding.AanvragerVoornaam = $extract(line,25,40)

	return st
}

}
