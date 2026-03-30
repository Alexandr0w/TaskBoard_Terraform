terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.66.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = var.azure_subscription_id
}

resource "azurerm_resource_group" "arg" {
  name     = "${var.resource_group_name}-${random_integer.ri.result}"
  location = var.resource_group_location
}

resource "random_integer" "ri" {
  min = var.random_integer_min
  max = var.random_integer_max
}

resource "azurerm_service_plan" "asp" {
  name                = "${var.app_service_plan_name}-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  os_type             = var.os_type_name
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "alwapp" {
  name                = "${var.app_service_name}-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_service_plan.asp.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      dotnet_version = var.dotnet_version
    }
    always_on = false
  }

  connection_string {
    name  = var.connection_string_name
    type  = var.connection_string_type
    value = "Data Source=tcp:${azurerm_mssql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.database.name};User ID=${azurerm_mssql_server.sqlserver.administrator_login};Password=${azurerm_mssql_server.sqlserver.administrator_login_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
  }
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "${var.sql_server_name}-${random_integer.ri.result}"
  resource_group_name          = azurerm_resource_group.arg.name
  location                     = azurerm_resource_group.arg.location
  version                      = var.sql_server_version
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = var.sql_server_minimum_tls_version
}

resource "azurerm_mssql_database" "database" {
  name                 = var.sql_database_name
  server_id            = azurerm_mssql_server.sqlserver.id
  collation            = var.sql_database_collation
  license_type         = var.sql_database_license_type
  max_size_gb          = var.sql_database_max_size_gb
  sku_name             = var.sql_database_sku_name
  zone_redundant       = false
  storage_account_type = var.sql_database_storage_account_type

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_mssql_firewall_rule" "firewall_rule" {
  name             = var.firewall_rule_name
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = var.firewall_rule_start_ip
  end_ip_address   = var.firewall_rule_end_ip
}

resource "azurerm_app_service_source_control" "assc" {
  app_id                 = azurerm_linux_web_app.alwapp.id
  repo_url               = var.repo_URL
  branch                 = var.repo_branch
  use_manual_integration = true
}
