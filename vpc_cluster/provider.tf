##############################################################################
# Terraform Providers
##############################################################################

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.37.1"
    }
  }
}

##############################################################################

##############################################################################
# Await Cluster Data To Initialize Kubernetes Provider
##############################################################################

data ibm_container_cluster_config cluster {
  cluster_name_id   = ibm_container_vpc_cluster.cluster.id
  resource_group_id = var.resource_group_id
  config_dir        = path.root
  admin             = true
  network           = true
}

provider kubernetes {
  host                   = data.ibm_container_cluster_config.cluster.host
  client_certificate     = data.ibm_container_cluster_config.cluster.admin_certificate
  client_key             = data.ibm_container_cluster_config.cluster.admin_key
  cluster_ca_certificate = data.ibm_container_cluster_config.cluster.ca_certificate
}

##############################################################################