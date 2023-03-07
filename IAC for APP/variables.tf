variable "app_plan_name" {
  type        = "Adeola-BH-App-Plan"
  description = "Azure App Service Plan Name"
}

variable "web_app_name" {
  type        = "Adeola-BH-App"
  description = "Azure Web App Name"
}
variable "registry_name" {
  type        = "AdeolaBHregistry"
  description = "Azure Web App Name"
}
variable "tag_name" {
  type        = "adeimage-ysd2021/spring-boot-react-example"
  description = "Azure Web App Name"
 default: "latest"
}
variable "resource_group_name" {
  type        = "BH-App-Group"
  description = "Azure Resource Group Name"
}
variable "location" {
  type        = "westeurope"
  description = "Azure Resource Region Location"
}