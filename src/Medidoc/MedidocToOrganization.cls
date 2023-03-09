Class Medidoc.MedidocToOrganization Extends Ens.DataTransformDTL [ DependsOn = (Medidoc.MedidocPerPatient, HS.FHIR.DTL.vR4.Model.Resource.Organization) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Medidoc.MedidocPerPatient' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Organization' create='new' language='objectscript' >
<assign value='"https://www.ehealth.fgov.be/standards/fhir/core/StructureDefinition/be-organization"' property='target.meta.profile.(1)' action='set' />
<assign value='"Organization1"' property='target.id' action='set' />
<assign value='$P(source.Bestandshoofding.laboStad, " ", 2, *)' property='target.address.(1).city' action='set' />
<assign value='$P(source.Bestandshoofding.laboStad, " ", 1)' property='target.address.(1).postalCode' action='set' />
<assign value='"BE"' property='target.address.(1).country' action='set' />
<assign value='source.Bestandshoofding.laboStraat' property='target.address.(1).line.(1)' action='set' />
<assign value='source.Bestandshoofding.laboStraat _ ", " _source.Bestandshoofding.laboStad' property='target.address.(1).text' action='set' />
<assign value='$P(source.Bestandshoofding.laboContact, " ", 2, *)' property='target.telecom.(1).value' action='set' />
<assign value='source.Bestandshoofding.laboNaam' property='target.name' action='set' />
<assign value='"official"' property='target.identifier.(1).use' action='set' />
<assign value='"http://terminology.hl7.org/CodeSystem/v2-0203"' property='target.identifier.(1).type.coding.(1).system' action='set' />
<assign value='"Medical License number"' property='target.identifier.(1).type.coding.(1).display' action='set' />
<assign value='"MD"' property='target.identifier.(1).type.coding.(1).code' action='set' />
<assign value='"https://www.ehealth.fgov.be/standards/fhir/core/NamingSystem/nihdi"' property='target.identifier.(1).system' action='set' />
<assign value='source.Bestandshoofding.laboRiziv' property='target.identifier.(1).value' action='set' />
<assign value='"empty"' property='target.text.status' action='set' />
<assign value='"&lt;div xmlns=""http://www.w3.org/1999/xhtml""&gt;empty&lt;/div&gt;"' property='target.text.div' action='set' />
</transform>
}

}
