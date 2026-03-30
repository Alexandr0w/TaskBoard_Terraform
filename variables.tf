variable "azure_subscription_id" {
  description = "The subscription ID to use for deploying resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "resource_group_location" {
  description = "The Azure region in which to create the resources."
  type        = string
}

variable "random_integer_min" {
  description = "The minimum value for the random integer."
  type        = number
}

variable "random_integer_max" {
  description = "The maximum value for the random integer."
  type        = number
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan to create."
  type        = string
}

variable "os_type_name" {
  description = "The type of operating system for the App Service Plan."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the App Service Plan."
  type        = string
}

variable "app_service_name" {
  description = "The name of the App Service to create."
  type        = string
}

variable "dotnet_version" {
  description = "The version of .NET to use for the App Service."
  type        = string
}

variable "connection_string_name" {
  description = "The name of the connection string for the App Service."
  type        = string
}

variable "connection_string_type" {
  description = "The type of the connection string for the App Service."
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL Server to create."
  type        = string
}

variable "sql_server_version" {
  description = "The version of SQL Server to use."
  type        = string

}

variable "sql_server_minimum_tls_version" {
  description = "The minimum TLS version for the SQL Server."
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database to create."
  type        = string
}

variable "sql_database_collation" {
  description = "The collation for the SQL Database."
  type        = string
}

variable "sql_database_license_type" {
  description = "The license type for the SQL Database."
  type        = string
}

variable "sql_database_max_size_gb" {
  description = "The maximum size for the SQL Database in GB."
  type        = number
}

variable "sql_database_sku_name" {
  description = "The SKU name for the SQL Database."
  type        = string
}

variable "sql_database_storage_account_type" {
  description = "The storage account type for the SQL Database."
  type        = string
}

variable "sql_admin_username" {
  description = "The login for the SQL Server administrator."
  type        = string
}

variable "sql_admin_password" {
  description = "The password for the SQL Server administrator."
  type        = string
}

variable "firewall_rule_name" {
  description = "The name of the firewall rule to create."
  type        = string
}

variable "firewall_rule_start_ip" {
  description = "The starting IP address for the firewall rule."
  type        = string
}

variable "firewall_rule_end_ip" {
  description = "The ending IP address for the firewall rule."
  type        = string
}

variable "repo_URL" {
  description = "The URL of the repository."
  type        = string
}

variable "repo_branch" {
  description = "The branch of the repository."
  type        = string
}