#! /bin/bash

function start
{
    cat << EOF | iris session iris
    /// install zpm
    zn "%SYS" d ##class(Security.SSLConfigs).Create("z") s r=##class(%Net.HttpRequest).%New(),r.Server="pm.community.intersystems.com",r.SSLConfiguration="z" d r.Get("/packages/zpm/latest/installer"),\$system.OBJ.LoadStream(r.HttpResponse.Data,"c")

    zn "%SYS"
    Do ##class(Security.Users).UnExpireUserPasswords("*")
    
    // Create web application ...
    zw ##class(Security.Applications).Import("/opt/irisapp/misc/application-export.xml")

    do ##class(Security.Applications).Delete("/api/medidoc")
    set params("AutheEnabled") = 64
    set params("AutoCompile") = 1
    set params("Description") = "Medidoc web application"
    set params("DispatchClass") = "Medidoc.disp"
    set params("Enabled") = 1
    set params("InbndWebServicesEnabled") = 0
    set params("IsNameSpaceDefault") = 0
    set params("LockCSPName") = 1
    set params("MatchRoles") = ":%All"
    set params("NameSpace") = "HEALTHTOOLKIT"
    set sc = ##class(Security.Applications).Create("/api/medidoc", .params)
    w sc

    zn "HSLIB"
    // Install a Foundation namespace and change to it
    Do ##class(HS.HC.Util.Installer).InstallFoundation("HEALTHTOOLKIT")
    zn "HEALTHTOOLKIT"

    // Install FHIR repo
    Set appKey = "/api/fhir"
    Set strategyClass = "HS.FHIRServer.Storage.Json.InteractionsStrategy"
    Set metadataConfigKey = "HL7v40"

    // Install elements that are required for a FHIR-enabled namespace
    Do ##class(HS.FHIRServer.Installer).InstallNamespace()

    // Install an instance of a FHIR Service into the current namespace
    Do ##class(HS.FHIRServer.Installer).InstallInstance(appKey, strategyClass, metadataConfigKey)
    do ##class(Ens.Director).StopProduction()
    do \$system.OBJ.ImportDir("/opt/irisapp/src","*.cls","cdk",.errors,1)

    zw \$classmethod("Ens.Director", "SetAutoStart", "HEALTHTOOLKITPKG.FoundationProduction", 0)
    zw \$classmethod("Ens.Director", "StartProduction", "HEALTHTOOLKITPKG.FoundationProduction")

    set cspConfig = ##class(HS.Util.RESTCSPConfig).URLIndexOpen(appKey)
    set cspConfig.ServiceConfigName = "FHIR_Http_Service"
    set cspConfig.AllowUnauthenticatedAccess = 1
    zw cspConfig.%Save()

    set strategy = ##class(HS.FHIRServer.API.InteractionsStrategy).GetStrategyForEndpoint(appKey)
    set config = strategy.GetServiceConfigData()
    set config.DebugMode = 4
    do strategy.SaveServiceConfigData(config)

    do ##class(EnsLib.EDI.XML.SchemaXSD).Import("/opt/irisapp/misc/HS.SDA3.xsd",.tCatImported)

    ; zpm install openapi class definiton
    zpm 
    install swagger-ui
    q

    w ##class(Medidoc.ImportCSV).ImportCSV()

    halt
EOF

    cp /opt/irisapp/swagger.yml /usr/irissys/csp/swagger-ui/swagger.yml
    old=http://localhost:52773/crud/_spec
    new=./swagger.yml
    sed -i "s|$old|$new|g" /usr/irissys/csp/swagger-ui/index.html
}


##################################################################################################

start