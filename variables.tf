variable "region" {
  type = string
}

# Variables Configuration

variable "cluster-name" {
  type        = string
}

variable "availability-zones" {
  type        = list
}

variable "k8s-version" {
  type        = string
}

variable "kublet-extra-args" {
  default     = ""
  type        = string
  description = "Additional arguments to supply to the node kubelet process"
}

variable "public-kublet-extra-args" {
  default     = ""
  type        = string
  description = "Additional arguments to supply to the public node kubelet process"

}


variable "eks-cw-logging" {
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  type        = list
  description = "Enable EKS CWL for EKS components"
}

variable "node-instance-type" {
  type        = string
}

variable "root-block-size" {
  type        = string

}

variable "desired-capacity" {
  type        = string
}

variable "max-size" {
  type        = string
}

variable "min-size" {
  type        = string
}

variable "node-name" {
  type        = string
} 

###### VPC 


variable "vpc-name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}

variable "public_subnet_3_cidr" {
  type = string
}


variable "private_subnet_1_cidr" {
  type = string
}

variable "private_subnet_2_cidr" {
  type = string
}

variable "private_subnet_3_cidr" {
  type = string
}

variable "cluster_endpoint_private_access" {
  type = bool
}

variable "cluster_endpoint_public_access" {
  type = bool
}

###########ELASTICACHE##########

variable "cluster_id" {
  type        = string
}

variable "engine" {
  type        = string
}

variable "node_type" {
  type        = string
}

variable "num_cache_nodes" {
  type        = string
}

variable "parameter_group_name" {
  type        = string
}

variable "engine_version" {
  type        = string
}

variable "port" {
  type        = string
}