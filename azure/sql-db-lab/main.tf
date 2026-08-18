resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    project = var.project_name
    owner   = "purush"
    env     = "lab"
  }
}

module "sql" {
  source              = "./modules/sql_db"
  project_name        = var.project_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  sql_server_name = "${var.project_name}-sql-${random_string.suffix.result}"
  admin_login     = var.sql_admin_login
  admin_password  = var.sql_admin_password
  db_name         = "${var.project_name}-db"
  sku_name        = "GP_Gen5_2" # change to smallest acceptable; Basic deprecated, GP is common
  max_size_gb     = 2
  allowed_ip_cidr = var.allowed_ip_cidr
}

resource "random_string" "suffix" {
  length  = 5
  upper   = false
  lower   = true
  numeric = true
  special = false
}