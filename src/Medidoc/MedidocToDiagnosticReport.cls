Class Medidoc.MedidocToDiagnosticReport Extends Ens.DataTransformDTL [ DependsOn = (Medidoc.MedidocPerPatient, HS.FHIR.DTL.vR4.Model.Resource.DiagnosticReport) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Medidoc.MedidocPerPatient' targetClass='HS.FHIR.DTL.vR4.Model.Resource.DiagnosticReport' create='new' language='objectscript' >
<assign value='"DiagnosticReport1"' property='target.id' action='set' />
<assign value='"https://www.ehealth.fgov.be/standards/fhir/lab/StructureDefinition/be-laboratory-report"' property='target.meta.profile.(1)' action='set' />
<assign value='"1"' property='target.meta.versionId' action='set' />
<assign value='"empty"' property='target.text.status' action='set' />
<assign value='"&lt;div xmlns=""http://www.w3.org/1999/xhtml""&gt;empty&lt;/div&gt;"' property='target.text.div' action='set' />
<assign value='"https://www.ehealth.fgov.be/lab-report/diagnostic-report-id"' property='target.identifier.(1).system' action='set' />
<assign value='source.AanvraagHoofding.ReferentieNummerVanDeAanvraag' property='target.identifier.(1).value' action='set' />
<assign value='"ServiceRequest/ServiceRequest1"' property='target.basedOn.(1).reference' action='set' />
<assign value='"final"' property='target.status' action='set' />
<assign value='"http://terminology.hl7.org/CodeSystem/v2-0074"' property='target.category.(1).coding.(1).system' action='set' />
<assign value='"LAB"' property='target.category.(1).coding.(1).code' action='set' />
<assign value='"Laboratory"' property='target.category.(1).coding.(1).display' action='set' />
<assign value='"en"' property='target.language' action='set' />
<assign value='"Patient/Patient1"' property='target.subject.reference' action='set' />
<assign value='##class(Medidoc.Util).MedidocToFhirDate(source.Bestandshoofding.aanmaakDatum)' property='target.issued' action='set' />
<assign value='"Organization/Organization1"' property='target.performer.(1).reference' action='set' />
<assign value='"Practitioner/Practitioner1"' property='target.resultsInterpreter.(1).reference' action='set' />
</transform>
}

}
