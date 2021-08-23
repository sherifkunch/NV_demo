variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}
variable "username" {
  type        = string
  description = "RDS master username."
}
variable "db_password" {
  description = "RDS root user password"
  type	      = string
  sensitive   = true
}
variable "identifier" {
  type        = string
  description = "RDS identifier."
}
variable "tags" {
  type        = map(any)
  default     = {}
  description = "Resource tags."
}
variable "enabled_ssm_parameter_store" {
  type        = bool
  default     = true
  description = "Save RDS credentials to SSM Parameter Store."
}
variable "key_name" {
 default = "NV_project.pem"
}
