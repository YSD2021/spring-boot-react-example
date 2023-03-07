variable "app_plan_name" {
  default        = "Adeola-BH-App-Plan"
  description = "Azure App Service Plan Name"
}

variable "web_app_name" {
  default        = "Adeola-BH-App"
  description = "Azure Web App Name"
}
variable "registry_name" {
  default        = "AdeolaBHregistry"
  description = "Azure Web App Name"
}
variable "tag_name" {
  default        = "adeimage-ysd2021/spring-boot-react-example"
  description = "Azure Web App Name"
}
variable "resource_group_name" {
  default        = "BH-App-Group"
  description = "Azure Resource Group Name"
}
variable "location" {
  default        = "westeurope"
  description = "Azure Resource Region Location"
}