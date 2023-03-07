locals {
  tags_common = merge(var.tags_extra, {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  })
  name_prefix = "${var.project}-${var.environment}"
  env = {
    default = {
      location           = "westeurope"
      backend_image     = "adeimage-ysd2021/spring-boot-react-example"
      backend_image_tag = "1.0.0"
      backend_port      = 8080
      backend_domain = "${var.environment}.${var.project}.com"
    }
  }
  workspace       = contains(keys(local.env), var.environment) ? var.environment : "default"
  environmentvars = merge(local.env["default"], local.env[local.workspace])
}