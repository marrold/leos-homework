locals {
   node_groups = {
    sip-proxy-1-1 = {
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1
      instance_type    = "t2.medium"
      "k8s_labels" = {
         "some_label" = "some_value"
      }
      "additional_tags" = {
         "some_tag" = "some_value"
      }
    }
    sip-proxy-1-2 = {
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1
      instance_type    = "t2.medium"
      "k8s_labels" = {
         "some_label" = "some_value"
      }
      "additional_tags" = {
         "some_tag" = "some_value"
      }
    }
  }

  subnets = {
     sip-proxy-1-1 = "some subnet 1"
     sip-proxy-1-2 =  "some subnet 2"
  }

  merged_node_groups = {
     for node_name, node_data in local.node_groups :
        node_name => merge(node_data, {
           "node_name" = node_name, 
           "subnet" = local.subnets[node_name]
           "k8s_labels" = merge(local.node_groups[node_name].k8s_labels, {"name" = node_name})
           "additional_tags" = merge(local.node_groups[node_name].additional_tags, {"name" = node_name})
         })
  }

}

module "leo" {
   source = "./module"

   node_groups = local.merged_node_groups
}