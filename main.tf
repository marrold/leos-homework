locals {
   node_groups = {
    vsps-sip-proxy-1-1 = {
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1
      instance_type    = "t2.medium"
      k8s_labels       = {}
      additional_tags  = {}
    }
    vsps-sip-proxy-1-2 = {
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1
      instance_type    = "t2.medium"
      k8s_labels       = {}
      additional_tags  = {}
    }
  }

  subnets = {
     vsps-sip-proxy-1-1 = "some subnet 1"
     vsps-sip-proxy-1-2 =  "some subnet 2"
  }

  merged_node_groups = flatten([
     for node_name in  keys(local.node_groups) : {
        format("%s", node_name) = merge(local.node_groups[node_name], {"node_name" = node_name, "subnet" = local.subnets[node_name]})
     }
  ])

}

module "leo" {
   source = "./module"

   node_groups = local.merged_node_groups
}