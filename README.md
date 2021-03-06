# Red Hat OpenShift on VPC

This architecture creates a multizone VPC and an Openshift cluster on that VPC secured with IBM Cloud KeyProtect. [Read more about Openshift on IBM Cloud here](https://cloud.ibm.com/docs/openshift?topic=openshift-getting-started).

![Red Hat OpenShift on VPC](./.docs/arch-roks.png)
---

## Table of Contents

1. [Multizone VPC](#multizone-vpc)
2. [VPC Cluster](#vpc-cluster)
3. [Resources](#resources)

---

## Multizone VPC

This module creates a VPC in three zones of a single region, creates the ACL used by those subnets, and optionally provisions public gateways in all three zones. To read more about this module, refer to the [Multizone VPC README](./multizone_vpc/README.md).

---

## VPC Cluster

This module provisions a private Openshift cluster for this architecture. Optinally, it can enable ALBs and create additional worker pools. To read more about this module, refer to the [VPC Cluster README](./vpc_cluster/README.md)

---

## Resources

This module provisions instances of Cloud Object Storage, Key Protect, LogDNA and Sysdig. Your images in your OpenShift cluster internal registry are automatically backed up to an IBM Cloud Object Storage bucket. Key Protect is used for encryption of worker nodes. LogDNA and Sysdig are used for logging and monitoring of the cluster. [Resources README](./resources/README.md)

---

## Module Variables

Variable | Type | Description | Default
---------|------|-------------|--------
`ibmcloud_api_key` | string | The IBM Cloud platform API key needed to deploy IAM enabled resources |
`unique_id` | string | A unique identifier need to provision resources. Must begin with a letter | `demo`
`ibm_region` | string | IBM Cloud region where all resources will be deployed |
`resource_group` | string | Name of resource group to create VPC | `default`
`enable_public_gateway` | String | Enable public gateways for subnets, true or false | `true`
`acl_rules` | String | Access control list rule set |  `[`<br> `{` <br> `name        = "egress"`<br>  `action      = "allow"`<br>  `source      = "0.0.0.0/0"` <br>  `destination = "0.0.0.0/0"`<br>  `direction   = "inbound"`<br>`},`<br>`{` <br> `name        = "ingress"` <br>  `action      = "allow"`<br>  `source      = "0.0.0.0/0"`<br> `destination = "0.0.0.0/0"`<br>  `direction   = "outbound"`<br>`}` <br> `]`
`machine_type` | string | The flavor of VPC worker node to use for your cluster | `bx2.4x16`
`workers_per_zone` | number | Number of workers to provision in each subnet. For load balancing to work, worker pool size must be 2 or greater. | `2`
`disable_public_service_endpoint` | bool | Disable public service endpoint for cluster | `false`
`entitlement` | string | If you purchased an IBM Cloud Cloud Pak that includes an entitlement to run worker nodes that are installed with OpenShift Container Platform, enter entitlement to create your cluster with that entitlement so that you are not charged twice for the OpenShift license. Note that this option can be set only when you create the cluster. After the cluster is created, the cost for the OpenShift license occurred and you cannot disable this charge. | `cloud_pak`
`kube_version` | string | Specify the Kubernetes version, including the major.minor version. To see available versions, run ibmcloud ks versions. To use the default, leave string empty | `4.8.21_openshift`
`wait_till` | string | To avoid long wait times when you run your Terraform code, you can specify the stage when you want Terraform to mark the cluster resource creation as completed. Depending on what stage you choose, the cluster creation might not be fully completed and continues to run in the background. However, your Terraform code can continue to run without waiting for the cluster to be fully created. Supported args are `MasterNodeReady`, `OneWorkerNodeReady`, and `IngressReady` | `IngressReady`
`tags` | list(string) | A list of tags to add to the cluster | `[]`
`worker_pools` | String | List of maps describing worker pools. Worker pools must have at least 2 workers per zone | `[]`
