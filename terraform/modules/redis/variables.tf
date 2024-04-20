variable "cluster_id" {
  type = string
}
variable "engine" {
  type = string
}
variable "engine_version" {
  type = string
}
variable "node_type" {
  type = string
}
variable "num_cache_nodes" {
  type = number
}
variable "port" {
  type = number
}

variable "subnet_group_name" {
  type = string
}

variable "subnet_ids" {
 type = list(any)
}