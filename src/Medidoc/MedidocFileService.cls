Class Medidoc.MedidocFileService Extends Ens.BusinessService
{

Method OnProcessInput(pInput As %Stream.Object, Output pOutput As %Stream.Object) As %Status
{
	// parse exact 1 bestandshoofding
	set st = ##class(Medidoc.Parser.BestandsHoofdingParser).parseBestandsHoofding(.pInput,.bestandshoofding)
	
	// parse 1 of meerdere AanvraagHoofdingen
	Set line=""
	
	while (1) {
		set st =  ##class(Medidoc.Parser.AanvraagHoofdingParser).parseAanvraagHoofding(.pInput,.aanvraaghoofding)
		
		// zonder ingevulde aanvraag hoofding stoppen we
		if ( aanvraaghoofding.isEmpty()) {
			Quit
		} 	
	
		set tMedidoc = ##class(Medidoc.Request).%New()
		set tMedidocPerPatient = ##class(Medidoc.MedidocPerPatient).%New()
		
		
		set tMedidocPerPatient.Bestandshoofding = bestandshoofding
		set tMedidocPerPatient.AanvraagHoofding = aanvraaghoofding
		
		set tMedidoc.MedidocPerPatient = tMedidocPerPatient
		
		set sc = ..SendRequestSync("MedidocToFHIR",tMedidoc, .tResponse)
		if ($$$ISERR(sc))
		{
			set pOutput = sc
			return sc
		}
		if (tResponse.error = "Some results are missing due to missing mapping between MedidocCode and LoincCode")
		{
			set pOutput = tResponse.error
			return sc
		}
		set pOutput = tResponse.body
	}
	
	Quit st
}

}
