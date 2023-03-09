/// 
Class Medidoc.MedidocToFHIRProcess Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Medidoc.Request' response='Medidoc.FHIRResponse' height='2100' width='2000' >
<context>
<property name='FHIRBundle' type='HS.FHIR.DTL.vR4.Model.Resource.Bundle' instantiate='0' />
</context>
<sequence xend='200' yend='700' >
<transform name='Medidoc to FHIR' class='Medidoc.MedidocToFHIRTransform' source='request' target='context.FHIRBundle' xpos='200' ypos='250' />
<if condition='(context.FHIRBundle.entry.GetAt(4).resource.conclusion = "Some results are missing due to missing mapping between MedidocCode and LoincCode")' xpos='200' ypos='350' xend='200' yend='600' >
<true>
<code xpos='466' ypos='500' >
<![CDATA[  set response.body = context.FHIRBundle.ToJSON() 
 set response.error = "Some results are missing due to missing mapping between MedidocCode and LoincCode"]]>
</code>
</true>
<false>
<code xpos='200' ypos='500' >
<![CDATA[ set response.body = context.FHIRBundle.ToJSON()
 set response.error = "ok"]]>
</code>
</false>
</if>
</sequence>
</process>
}

}
