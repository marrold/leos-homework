
# leos-homework

My good friend Leo needed some help with his homework. He wanted to use Terragrunt with Terraform, with some variables defined in YAML.

This was the data structure:

    nodegroups:
          sip-proxy-1-1:
            instance_type: m5.large # (default: t2.medium  t2.small is the lowest for EKS)
            desired_capacity: 1
            max_capacity: 1
            min_capacity: 1
            k8s_labels:
              some_label: "some_value"
            additional_tags:
              some_label: "some_value"
          sip-proxy-1-2:
            instance_type: m5.large # (default: t2.medium  t2.small is the lowest for EKS)
            desired_capacity: 1
            max_capacity: 1
            min_capacity: 1
            k8s_labels:
              some_label: "some_value"
            additional_tags:
              some_tag: "some_value"

But he also wanted to merge in some subnets, so by the time Terraform had spat it out, it looked something like this:

    node_groups = {
      "sip-proxy-1-1" = {
        "additional_tags" = {}
        "desired_capacity" = 1
        "instance_type" = "t2.medium"
        "k8s_labels" = {}
        "max_capacity" = 1
        "min_capacity" = 1
        "node_name" = "sip-proxy-1-1"
        "subnet" = "some subnet 1"
        "k8s_labels" = {
          "name" = "sip-proxy-1-1"
          "some_label" = "some_value"
        }
        "additional_tags" = {
          "name" = "sip-proxy-1-1"
          "some_tag" = "some_value"
        }
      }
      "sip-proxy-1-2" = {
        "additional_tags" = {}
        "desired_capacity" = 1
        "instance_type" = "t2.medium"
        "k8s_labels" = {}
        "max_capacity" = 1
        "min_capacity" = 1
        "node_name" = "sip-proxy-1-2"
        "subnet" = "some subnet 2"
        "k8s_labels" = {
          "name" = "sip-proxy-1-2"
          "some_label" = "some_value"
        }
        "additional_tags" = {
          "name" = "sip-proxy-1-2"
          "some_tag" = "some_value"
        }
      }
    }

I've created some functional pseudocode to do just that. I'll leave it here for posterity 
