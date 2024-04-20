variable "ec2_task_execution_role_name" {
  description = "ECS task execution role name"
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role name"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}

variable "app_count" {
  description = "Number of docker containers to run"
}

variable "health_check_path" {
  description = "health path"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
}
variable "aws_region" {
  description = "The AWS region things are created in"
}
variable "subnets" {
  description = "lb subnets"
}

variable "lb_security_groups" {
  description = "lb security group"
  type        = list(string)
}

variable "vpc_id" {
  description = "vpc id"
}
variable "sg_ecs_tasks" {
  description = "value for ecs tasks sg"
}