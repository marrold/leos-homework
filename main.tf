locals {
   node_groups = {
    vsps-sip-proxy-1-1 = {
      node_group_name  = "vsps-sip-proxy-1-1"
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1
      instance_type    = "t2.medium"
      k8s_labels       = {}
      additional_tags  = {}
    }
    vsps-sip-proxy-1-2 = {
      node_group_name  = "vsps-sip-proxy-1-2"
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

  merged_node_groups = {
     for group in local.node_groups :
       group.node_group_name => merge(group, {"subnet" = local.subnets[group.node_group_name]})
  }
}


module "leo" {
   source = "./module"

   node_groups = local.merged_node_groups
}