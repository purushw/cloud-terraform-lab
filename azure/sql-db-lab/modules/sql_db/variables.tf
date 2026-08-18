variable "project_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }

variable "sql_server_name" { type = string }
variable "admin_login" { type = string }
variable "admin_password" { 
    type = string 
    sensitive = true 
}

variable "db_name" { type = string }
variable "sku_name" { type = string }      # e.g., "GP_Serveless" / "GP_Gen5_2"
variable "max_size_gb" { type = number }   # e.g., 2
variable "allowed_ip_cidr" { 
    type = string 
    default = null 
}