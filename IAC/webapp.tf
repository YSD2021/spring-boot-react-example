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

locals {
 env_variables = {
   DOCKER_REGISTRY_SERVER_URL            = "adeolabhregistry.azurecr.io"
   DOCKER_REGISTRY_SERVER_USERNAME       = var.SERVER_USERNAME
   DOCKER_REGISTRY_SERVER_PASSWORD       = var.SERVER_PASSWORD
       WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
	WEBSITES_PORT = 8080
 }
}
resource "azurerm_app_service" "my_app_service_container" {
 name                = "Ade-BH-App"
 location            = azurerm_app_service_plan.my_service_plan.location
 resource_group_name     = azurerm_app_service_plan.my_service_plan.resource_group_name
 app_service_plan_id     = azurerm_app_service_plan.my_service_plan.id
 site_config {
   always_on = "true"

   linux_fx_version  = "DOCKER|adeolabhregistry.azurecr.io/adeimage-ysd2021/spring-boot-react-example:82" #define the images to usecfor you application
 }

 app_settings = local.env_variables 
}

resource "azurerm_application_insights" "my_app_insight" {
 name                = "my_app_insight"
 location            = azurerm_app_service_plan.my_service_plan.location
 resource_group_name = azurerm_app_service_plan.my_service_plan.resource_group_name
 }