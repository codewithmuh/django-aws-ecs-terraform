variable "subnet_ids" {
  type = list(any)
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "vpc_id" {
  type = string
}