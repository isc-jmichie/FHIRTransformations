Class Medidoc.MedidocToPatient Extends Ens.DataTransformDTL [ DependsOn = (Medidoc.MedidocPerPatient, HS.FHIR.DTL.vR4.Model.Resource.Patient) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Medidoc.MedidocPerPatient' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Patient' create='new' language='objectscript' >
<assign value='"https://www.ehealth.fgov.be/standards/fhir/core/StructureDefinition/be-patient"' property='target.meta.profile.(1)' action='set' />
<assign value='"Patient1"' property='target.id' action='set' />
<assign value='"empty"' property='target.text.status' action='set' />
<assign value='"&lt;div xmlns=""http://www.w3.org/1999/xhtml""&gt;empty&lt;/div&gt;"' property='target.text.div' action='set' />
<assign value='"official"' property='target.identifier.(1).use' action='set' />
<assign value='"https://www.ehealth.fgov.be/standards/fhir/core/NamingSystem/ssin"' property='target.identifier.(1).system' action='set' />
<assign value='source.AanvraagHoofding.Pid' property='target.identifier.(1).value' action='set' />
<assign value='1' property='target.active' action='set' />
<assign value='source.AanvraagHoofding.AchterNaamPatient' property='target.name.(1).family' action='set' />
<assign value='source.AanvraagHoofding.VoornaamPatient' property='target.name.(1).given.(1)' action='set' />
<if condition='source.AanvraagHoofding.geslachtPatient = "X"' >
<true>
<assign value='"female"' property='target.gender' action='set' />
</true>
</if>
<if condition='source.AanvraagHoofding.geslachtPatient = "Y"' >
<true>
<assign value='"male"' property='target.gender' action='set' />
</true>
<false>
<assign value='"unknown"' property='target.gender' action='set' />
</false>
</if>
<assign value='##class(Medidoc.Util).MedidocToFhirDate(source.AanvraagHoofding.geboortedatumPatient)' property='target.birthDate' action='set' />
<assign value='source.AanvraagHoofding.woonplaatsPatient' property='target.address.(1).city' action='set' />
<assign value='source.AanvraagHoofding.straatnaamEnHuisnummerPatient' property='target.address.(1).line.(1)' action='set' />
<assign value='source.AanvraagHoofding.postcodePatient' property='target.address.(1).postalCode' action='set' />
<assign value='source.AanvraagHoofding.straatnaamEnHuisnummerPatient_", "_source.AanvraagHoofding.postcodePatient_" "_source.AanvraagHoofding.woonplaatsPatient' property='target.address.(1).text' action='set' />
<assign value='"BE"' property='target.address.(1).country' action='set' />
</transform>
}

}
