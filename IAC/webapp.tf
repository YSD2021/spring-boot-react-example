resource "azurerm_app_service_plan" "my_service_plan" {
 name                = "Ade-BH-AppPlan"
 location            = "westeurope"
 resource_group_name = "AdeolaBHresource-group"
 kind                = "Linux"
 reserved            = true

 sku {
    tier = "Standard"
    size = "S1"
 }
}

data "azurerm_user_assigned_identity" "assigned_identity_acr_pull" {
 provider            = azurerm.acr_sub
 name                = "User_ACR_pull"
 resource_group_name = "AdeolaBHresource-group"
}

locals {
 env_variables = {
   DOCKER_REGISTRY_SERVER_URL            = "adeolabhregistry.azurecr.io"
   DOCKER_REGISTRY_SERVER_USERNAME       = "AdeolaBHregistry"
   DOCKER_REGISTRY_SERVER_PASSWORD       = "2KUofEeXe3mP529mkEG+EsOpZThd0GshNFeBWDiAx1+ACRDuUFgT"
 }
}
resource "azurerm_app_service" "my_app_service_container" {
 name                = "Ade-BH-App"
 location            = "westeurope"
 resource_group_name     = "AdeolaBHresource-group"
 app_service_plan_id     = azurerm_app_service_plan.my_service_plan.id
 site_config {
   always_on = "true"

   linux_fx_version  = "DOCKER|adeolabhregistry.azurecr.io/adeimage-ysd2021/spring-boot-react-example:latest" #define the images to usecfor you application
 }

 identity {
   type         = "SystemAssigned, UserAssigned"
   identity_ids = [data.azurerm_user_assigned_identity.assigned_identity_acr_pull.id]
 }

 app_settings = local.env_variables 
}