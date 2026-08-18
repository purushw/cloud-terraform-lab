variable "project_name" {
  description = "Short name for tagging and names."
  type        = string
  default     = "db-lab"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "australiaeast"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-db-lab"
}

variable "allowed_ip_cidr" {
  description = "CIDR to allow to SQL (e.g., your public IP /32)"
  type        = string
  default     = null
}

variable "sql_admin_login" {
  description = "SQL admin username"
  type        = string
  default     = "sqladminpurush"
}

variable "sql_admin_password" {
  description = "SQL admin password"
  type        = string
  sensitive   = true
}