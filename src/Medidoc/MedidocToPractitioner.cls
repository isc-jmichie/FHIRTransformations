Class Medidoc.MedidocToPractitioner Extends Ens.DataTransformDTL [ DependsOn = (Medidoc.MedidocPerPatient, HS.FHIR.DTL.vR4.Model.Resource.Practitioner) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Medidoc.MedidocPerPatient' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Practitioner' create='new' language='objectscript' >
<assign value='"Practitioner1"' property='target.id' action='set' />
<assign value='"https://www.ehealth.fgov.be/standards/fhir/core/StructureDefinition/be-practitioner"' property='target.meta.profile.(1)' action='set' />
<assign value='"&lt;div xmlns=""http://www.w3.org/1999/xhtml""&gt;empty&lt;/div&gt;"' property='target.text.div' action='set' />
<assign value='"official"' property='target.identifier.(1).use' action='set' />
<assign value='"https://www.ehealth.fgov.be/standards/fhir/core/NamingSystem/nihdi"' property='target.identifier.(1).system' action='set' />
<assign value='source.Bestandshoofding.aanvragerRiziv' property='target.identifier.(1).value' action='set' />
<assign value='"official"' property='target.name.(1).use' action='set' />
<assign value='source.Bestandshoofding.AanvragerAchternaam' property='target.name.(1).family' action='set' />
<assign value='source.Bestandshoofding.AanvragerVoornaam' property='target.name.(1).given.(1)' action='set' />
<assign value='"empty"' property='target.text.status' action='set' />
</transform>
}

}
