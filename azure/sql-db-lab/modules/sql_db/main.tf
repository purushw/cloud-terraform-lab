resource "azurerm_mssql_server" "server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password

  identity {
    type = "SystemAssigned"
  }

  tags = {
    project = var.project_name
    env     = "lab"
  }
}

resource "azurerm_mssql_database" "db" {
  name           = var.db_name
  server_id      = azurerm_mssql_server.server.id
  sku_name       = var.sku_name
  max_size_gb    = var.max_size_gb
  zone_redundant = false

  tags = {
    project = var.project_name
    env     = "lab"
  }
}

# Optional: Allow Azure services
resource "azurerm_mssql_firewall_rule" "allow_azure" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Optional: Allow your public IP
resource "azurerm_mssql_firewall_rule" "allow_me" {
  count            = var.allowed_ip_cidr == null ? 0 : 1
  name             = "AllowPurush"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = chomp(element(split("/", var.allowed_ip_cidr), 0))
  end_ip_address   = chomp(element(split("/", var.allowed_ip_cidr), 0))
}