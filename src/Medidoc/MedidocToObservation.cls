Class Medidoc.MedidocToObservation Extends Ens.DataTransformDTL [ DependsOn = (Medidoc.Uitslag, HS.FHIR.DTL.vR4.Model.Resource.Observation) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Medidoc.Uitslag' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Observation' create='new' language='objectscript' >
<assign value='""' property='tempCode' action='set' />
<assign value='""' property='tempDescription' action='set' />
<assign value='source.analyseID' property='tempMedidoc' action='set' />
<sql>
<![CDATA[SELECT LoincCode , Description INTO :tempCode, tempDescription FROM Medidoc.ConversionTable WHERE MedidocCode = :tempMedidoc]]></sql>
<if condition='SQLCODE &apos;= 0' >
<true>
<assign value='"medidoccode not found"' property='target.text.status' action='set' />
</true>
<false>
<if condition='source.uitslag &apos;= ""' >
<true>
<assign value='source.uitslag' property='target.valueString' action='set' />
</true>
</if>
<assign value='tempCode' property='target.code.coding.(1).code' action='set' />
<assign value='tempDescription' property='target.code.coding.(1).display' action='set' />
<assign value='"http://loinc.org"' property='target.code.coding.(1).system' action='set' />
<assign value='"https://www.ehealth.fgov.be/standards/fhir/lab/StructureDefinition/be-observation-laboratory"' property='target.meta.profile.(1)' action='set' />
<assign value='"empty"' property='target.text.status' action='set' />
<assign value='"&lt;div xmlns=""http://www.w3.org/1999/xhtml""&gt;empty&lt;/div&gt;"' property='target.text.div' action='set' />
<assign value='"final"' property='target.status' action='set' />
<assign value='"Patient/Patient1"' property='target.subject.reference' action='set' />
<assign value='"Organization/Organization1"' property='target.performer.(1).reference' action='set' />
</false>
</if>
<if condition='$LISTTOSTRING(source.commentaarlijnen.(1)) &apos;= ""'  expanded='false' >
<true>
<assign value='$LISTTOSTRING(source.commentaarlijnen.(1))' property='target.note.(1).text' action='set' />
</true>
</if>
<if condition='source.aanduidingPathologischNormaal &apos;= ""' >
<true>
<assign value='source.aanduidingPathologischNormaal' property='target.interpretation.(1).coding.(1).code' action='set' />
<assign value='"http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation"' property='target.interpretation.(1).coding.(1).system' action='set' />
</true>
</if>
<if condition='source.referenceRange &apos;= ""' >
<true>
<assign value='source.referenceRange' property='target.referenceRange.(1).text' action='set' />
</true>
</if>
</transform>
}

}
