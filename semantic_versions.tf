# variables.tf
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "example_project"
}

variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 1
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {
    "Environment" = "dev"
    "Owner"       = "team"
  }
}

# main.tf
resource "aws_instance" "example" {
  count = var.instance_count

  ami           = "ami-0c55b159cbfafe1f0"  # Example AMI ID
  instance_type = "t2.micro"

  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_name}-instance-${count.index}"
    }
  )

  # Trigger to recreate resource if time changes
  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "echo The time is ${timestamp()}"
  }
}

# outputs.tf
output "project_name" {
  description = "The name of the project"
  value       = var.project_name
}

output "instance_count" {
  description = "The number of instances"
  value       = var.instance_count
}

output "tags" {
  description = "The tags assigned to resources"
  value       = var.tags
}

# locals.tf
locals {
  # Local time to trigger resource recreation
  current_time = timestamp()
}
