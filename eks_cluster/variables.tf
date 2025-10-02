variable "project_name" {
  description = "Project name"
  type        = string

}

variable "region" {
  description = "values for the region"
  type        = string
}

## Carregando SSM Parameters  ##

variable "ssm_vpc" {
  description = "VPC ID"
  type        = string

}

variable "ssm_public_subnets" {
  description = "Public Subnet ID"
  type        = list(string)

}

variable "ssm_private_subnets" {
  description = "Private Subnet ID"
  type        = list(string)

}

variable "ssm_pod_subnets" {
  description = "Pods Subnet ID"
  type        = list(string)

}

## Opções EKS ##

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.31"

}

variable "auto_scale_option" {
  type = object({
    min     = number
    max     = number
    desired = number
  })
}

variable "nodes_instance_sizes" {
  description = "Instance size for the nodes"
  type        = list(string)

}

variable "addon_cni_version" {
  description = "Version of the CNI addon"
  type        = string
  default     = "v1.18.3-eksbuild.2"

}

variable "addon_core_dns_version" {
  description = "Version of the CoreDNS addon"
  type        = string
  default     = "v1.11.3-eksbuild.1"

}

variable "addon_kubeproxy_version" {
  description = "Version of the KubeProxy addon"
  type        = string
  default     = "v1.31.2-eksbuild.3"

}

### Node Groups Customization ###

variable "custom_ami_type" {
  description = "Custom AMI type for the node groups"
  type        = string
  default     = "BOTTLEROCKET_x86_64"

}


# ## HELM ###
variable "auto_scale_options" {
  description = "Auto scaling options for the cluster autoscaler"
  type = object({
    min = number
    max = number
  })
}
