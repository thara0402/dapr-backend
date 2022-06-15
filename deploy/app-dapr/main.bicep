param environmentName string = 'env-${resourceGroup().name}'
param containerAppName string = 'dapr-backend'
param location string = resourceGroup().location
param containerImage string = 'thara0402/dapr-backend:0.1.0'
param revisionSuffix string = ''
param isExternalIngress bool = false
param revisionMode string = 'single'
param isDaprenabled bool = true
param daprAppId string = 'dapr-backend'

resource environment 'Microsoft.App/managedEnvironments@2022-03-01' existing = {
  name: environmentName
}

module apps 'apps.bicep' = {
  name: 'container-apps'
  params: {
    containerAppName: containerAppName
    location: location
    environmentId: environment.id
    containerImage: containerImage
    revisionSuffix: revisionSuffix
    revisionMode: revisionMode
    isExternalIngress: isExternalIngress
    isDaprenabled: isDaprenabled
    daprAppId: daprAppId
  }
}
