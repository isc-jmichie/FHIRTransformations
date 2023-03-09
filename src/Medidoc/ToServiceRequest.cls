Class Medidoc.ToServiceRequest Extends Ens.DataTransformDTL [ DependsOn = (Medidoc.MedidocPerPatient, HS.FHIR.DTL.vR4.Model.Resource.ServiceRequest) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Medidoc.MedidocPerPatient' targetClass='HS.FHIR.DTL.vR4.Model.Resource.ServiceRequest' create='new' language='objectscript' >
<assign value='"ServiceRequest1"' property='target.id' action='set' />
<assign value='"empty"' property='target.text.status' action='set' />
<assign value='"&lt;div xmlns=""http://www.w3.org/1999/xhtml""&gt;empty&lt;/div&gt;"' property='target.text.div' action='set' />
<assign value='"order"' property='target.intent' action='set' />
<assign value='"unknown"' property='target.status' action='set' />
<assign value='"Patient/Patient1"' property='target.subject.reference' action='set' />
<assign value='"http://snomed.info/sct"' property='target.category.(1).coding.(1).system' action='set' />
<assign value='"108252007"' property='target.category.(1).coding.(1).code' action='set' />
<assign value='"Laboratory procedure"' property='target.category.(1).coding.(1).display' action='set' />
<assign value='"Practitioner/Practitioner1"' property='target.requester.reference' action='set' />
<assign value='"Organization/Organization1"' property='target.performer.(1).reference' action='set' />
<assign value='##class(Medidoc.Util).MedidocToFhirDate(source.AanvraagHoofding.datumVanDeAanvraag)' property='target.authoredOn' action='set' />
</transform>
}

}
