Class Medidoc.MedidocToFHIRTransform Extends Ens.DataTransformDTL [ DependsOn = (Medidoc.Request, HS.FHIR.DTL.vR4.Model.Resource.Bundle) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Medidoc.Request' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Bundle' create='new' language='objectscript' >
<assign value='"medidocBundle"' property='target.id' action='set' />
<assign value='"urn:ietf:rfc:3986"' property='target.identifier.system' action='set' />
<assign value='"urn:uuid:"_$System.Util.CreateGUID()' property='target.identifier.value' action='set' />
<assign value='"collection"' property='target.type' action='set' />
<assign value='$SYSTEM.Util.CreateGUID()' property='PatientUUID' action='set' />
<assign value='$SYSTEM.Util.CreateGUID()' property='OrganizationUUID' action='set' />
<assign value='$SYSTEM.Util.CreateGUID()' property='PractitionerUUID' action='set' />
<assign value='$SYSTEM.Util.CreateGUID()' property='DiagnosticReportUUID' action='set' />
<assign value='$SYSTEM.Util.CreateGUID()' property='ServiceRequestUUID' action='set' />
<assign value='"urn:uuid:"_PatientUUID' property='target.entry.(1).fullUrl' action='set' />
<subtransform class='Medidoc.MedidocToPatient' targetObj='target.entry.(1).resource' sourceObj='source.MedidocPerPatient' />
<assign value='"urn:uuid:"_OrganizationUUID' property='target.entry.(2).fullUrl' action='set' />
<subtransform class='Medidoc.MedidocToOrganization' targetObj='target.entry.(2).resource' sourceObj='source.MedidocPerPatient' />
<assign value='"urn:uuid:"_PractitionerUUID' property='target.entry.(3).fullUrl' action='set' />
<subtransform class='Medidoc.MedidocToPractitioner' targetObj='target.entry.(3).resource' sourceObj='source.MedidocPerPatient' />
<assign value='"urn:uuid:"_DiagnosticReportUUID' property='target.entry.(4).fullUrl' action='set' />
<subtransform class='Medidoc.MedidocToDiagnosticReport' targetObj='target.entry.(4).resource' sourceObj='source.MedidocPerPatient' />
<assign value='"urn:uuid:"_ServiceRequestUUID' property='target.entry.(5).fullUrl' action='set' />
<subtransform class='Medidoc.ToServiceRequest' targetObj='target.entry.(5).resource' sourceObj='source.MedidocPerPatient' />
<assign value='6' property='obsInd' action='set' />
<foreach property='source.MedidocPerPatient.AanvraagHoofding.uitslagen.Uitslagen()' key='k1' >
<subtransform class='Medidoc.MedidocToObservation' targetObj='tempObservation' sourceObj='source.MedidocPerPatient.AanvraagHoofding.uitslagen.Uitslagen.(k1)' />
<if condition='tempObservation.text.status = "medidoccode not found"' >
<true>
<assign value='"Some results are missing due to missing mapping between MedidocCode and LoincCode"' property='target.entry.(4).resource.conclusion' action='set' />
</true>
<false>
<assign value='"Observation"_(obsInd-5)' property='tempObservation.id' action='set' />
<assign value='"urn:uuid:"_$System.Util.CreateGUID()' property='target.entry.(obsInd).fullUrl' action='set' />
<assign value='tempObservation' property='target.entry.(obsInd).resource' action='set' />
<assign value='"Observation/Observation"_(obsInd-5)' property='target.entry.(4).resource.result.(obsInd-4).reference' action='set' />
<assign value='obsInd+1' property='obsInd' action='set' />
</false>
</if>
</foreach>
</transform>
}

}
