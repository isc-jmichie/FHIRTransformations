Class Medidoc.FileProd Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Medidoc.FileProd" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="MedidocFileService" Category="" ClassName="Medidoc.MedidocFileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="MedidocToFHIR" Category="" ClassName="Medidoc.MedidocToFHIRProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
