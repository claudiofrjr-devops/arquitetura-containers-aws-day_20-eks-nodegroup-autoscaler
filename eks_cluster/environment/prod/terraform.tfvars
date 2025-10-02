project_name = "linuxtips_cluster"

region = "us-east-2"

environment = "prod"

ssm_vpc = "/linuxtips_vpc/vpc/id"

ssm_public_subnets = [
  "/linuxtips_vpc/subnets/public/us-east-2a/linuxtips-public-1a",
  "/linuxtips_vpc/subnets/public/us-east-2b/linuxtips-public-1b",
  "/linuxtips_vpc/subnets/public/us-east-2c/linuxtips-public-1c"
]

ssm_private_subnets = [
  "/linuxtips_vpc/subnets/private/us-east-2a/linuxtips-private-1a",
  "/linuxtips_vpc/subnets/private/us-east-2b/linuxtips-private-1b",
  "/linuxtips_vpc/subnets/private/us-east-2c/linuxtips-private-1c"
]

ssm_pod_subnets = [
  "/linuxtips_vpc/subnets/private/us-east-2a/linuxtips-pods-1a",
  "/linuxtips_vpc/subnets/private/us-east-2b/linuxtips-pods-1b",
  "/linuxtips_vpc/subnets/private/us-east-2c/linuxtips-pods-1c"
]

## Opções K8s ##

k8s_version = "1.31"

auto_scale_option = {
  min     = 1
  max     = 2
  desired = 1
}
nodes_instance_sizes = [
  "t3.medium",
  "t3.large"
]