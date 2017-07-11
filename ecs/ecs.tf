# ECS cluster, service, repo and task definition.
# Docs: 
# - https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html
# - https://www.terraform.io/docs/providers/aws/r/ecs_service.html
# - https://www.terraform.io/docs/providers/aws/r/ecr_repository.html
# - https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html

resource "aws_ecr_repository" "yetanotherchris" {
  name = "yetanotherchris"
}

resource "aws_ecs_cluster" "yetanotherchris" {
  name = "yetanotherchris"
}

resource "aws_ecs_service" "letmein" {
  name            = "letmein"
  cluster         = "${aws_ecs_cluster.yetanotherchris.id}"
  task_definition = "${aws_ecs_task_definition.yetanotherchris.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.yetanotherchris-ecs.arn}"

  placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    elb_name       = "${aws_alb.yetanotherchris-ecs.name}"
    container_name = "letmein"
    container_port = 5000
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-west-1, eu-west-2]"
  }
}

# Example task definitions @ https://github.com/lbracken/docker-example/blob/master/aws-task-definition.json
resource "aws_ecs_task_definition" "yetanotherchris" {
  family = "service"

  # The JSON needs to start below containerDefinition: []
  container_definitions = "${file("./ecs/task-definition.json")}"

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }
}