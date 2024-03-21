
# resource "aws_ecs_cluster" "ecs_cluster" {
#   name = "ecs_cluster"
# }

# resource "aws_autoscaling_group" "ecs_asg" {
#  vpc_zone_identifier = [aws_subnet.zone_a_subnets_priv.id, aws_subnet.zone_b_subnets_priv.id]
#  desired_capacity    = 2
#  max_size            = 3
#  min_size            = 1

#  launch_template {
#    id      = aws_launch_template.ecs_lt.id
#    version = "$Latest"
#  }

#  tag {
#    key                 = "AmazonECSManaged"
#    value               = true
#    propagate_at_launch = true
#  }
# }


# resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
#  name = "test1"

#  auto_scaling_group_provider {
#    auto_scaling_group_arn = aws_autoscaling_group.ecs_asg.arn

#    managed_scaling {
#      maximum_scaling_step_size = 1000
#      minimum_scaling_step_size = 1
#      status                    = "ENABLED"
#      target_capacity           = 3
#    }
#  }
# }

# resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_capacity" {
#  cluster_name = aws_ecs_cluster.ecs_cluster.name

#  capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]

#  default_capacity_provider_strategy {
#    base              = 1
#    weight            = 100
#    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
#  }
# }

# resource "aws_ecs_task_definition" "ecs_task_definition" {
#  family             = "my-ecs-task"
#  network_mode       = "awsvpc"
#  execution_role_arn = "arn:aws:iam::532199187081:role/ecsTaskExecutionRole"
#  cpu                = 256
#  runtime_platform {
#    operating_system_family = "LINUX"
#    cpu_architecture        = "X86_64"
#  }
#  container_definitions = jsonencode([
#    {
#      name      = "dockergs"
#      image     = "public.ecr.aws/f9n5f1l7/dgs:latest"
#      cpu       = 256
#      memory    = 512
#      essential = true
#      portMappings = [
#        {
#          containerPort = 80
#          hostPort      = 80
#          protocol      = "tcp"
#        }
#      ]
#    }
#  ])
# }

# resource "aws_ecs_service" "ecs_service" {
#  name            = "my-ecs-service"
#  cluster         = aws_ecs_cluster.ecs_cluster.id
#  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
#  desired_count   = 2

#  network_configuration {
#    subnets         = [aws_subnet.zone_a_subnets_priv.id, aws_subnet.zone_b_subnets_priv.id]
#    security_groups = [aws_security_group.sg_web.id]
#  }

#  force_new_deployment = true
#  placement_constraints {
#    type = "distinctInstance"
#  }

#  triggers = {
#    redeployment = timestamp()
#  }

#  capacity_provider_strategy {
#    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
#    weight            = 100
#  }

#  load_balancer {
#    target_group_arn = aws_lb_target_group.lb-tg.arn
#    container_name   = "dockergs"
#    container_port   = 80
#  }

#  depends_on = [aws_autoscaling_group.ecs_asg]
# }





