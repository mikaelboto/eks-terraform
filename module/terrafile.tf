module "module_template" {
  source                           = "../"
  region                           = "us-east-1"
  cluster-name                     = "eks-inforplus-prod"
  cluster_endpoint_private_access  = true
  cluster_endpoint_public_access   = true
  availability-zones               = ["us-east-1a", "us-east-1b", "us-east-1c"]
  k8s-version                      = "1.23"
  node-name                        = "node-inforplus-prod"
  node-instance-type               = "t3.medium"
  root-block-size                  = "20"
  min-size                         = 2
  desired-capacity                 = 2
  max-size                         = 4
  vpc-name                         = "vpc-inforplus-prod"
  vpc_cidr                         = "10.10.0.0/16"
  public_subnet_1_cidr             = "10.10.0.0/20"
  public_subnet_2_cidr             = "10.10.16.0/20"
  public_subnet_3_cidr             = "10.10.32.0/20"
  private_subnet_1_cidr            = "10.10.48.0/20"
  private_subnet_2_cidr            = "10.10.64.0/20"
  private_subnet_3_cidr            = "10.10.80.0/20"

}