module "ecs_app" {
  source                       = "./modules/ecs"
  ec2_task_execution_role_name = "myEcsTaskExecutionRole"
  ecs_auto_scale_role_name     = "myEcsAutoScaleRole"
  app_image                    = "211125414208.dkr.ecr.us-east-1.amazonaws.com/django-app:production"
  app_port                     = 8000
  app_count                    = 1
  health_check_path            = "/"
  fargate_cpu                  = "1024"
  fargate_memory               = "2048"
  aws_region                   = terraform.workspace
  az_count                     = "2"
  subnets                      = module.network.public_subnet_ids
  sg_ecs_tasks                 = [module.security.ecs_tasks_security_group_id]
  vpc_id                       = module.network.vpc_id
  lb_security_groups           = [module.security.alb_security_group_id]
}

module "network" {
  source   = "./modules/network"
  az_count = "2"
}

module "security" {
  source   = "./modules/security"
  app_port = 8000
  vpc_id   = module.network.vpc_id
}

module "logs" {
  source            = "./modules/logs"
  log_group_name    = "/ecs/ecs-app"
  log_stream_name   = "ecs-log-stream"
  retention_in_days = 30
}

module "remote_backend" {
  source              = "./modules/backend"
  bucket_name         = "jeff-terraform-state-backend-test-3957932"
  dynamodb_table_name = "jeff-terraform-state-lock"
}

module "rds" {
  source     = "./modules/rds"
  depends_on = [module.network.vpc_id]
  subnet_ids = module.network.private_subnet_ids
  vpc_id     = module.network.vpc_id
}


module "s3" {
  source = "./modules/s3_img"
  bucket_name = "bucket-img-252563253"
}