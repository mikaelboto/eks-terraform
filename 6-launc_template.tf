resource "aws_launch_template" "lt-inforplus-prod" {
  name = "lt-inforplus-prod"

  instance_type = "t3.medium"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "lt-inforplus-prod"
    }
  }


}