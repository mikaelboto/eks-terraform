resource "aws_launch_template" "foo-pdv-sdx" {
  name = "omni-pdv-sandbox"

  instance_type = "t3.large"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "omni-pdv-sandbox"
    }
  }


}