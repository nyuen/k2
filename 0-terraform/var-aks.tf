# Variable Service Principal clientID
variable "spn_client_id" {
  type = string
}

# Variable Service Principal clientSecret
variable "spn_client_secret" {
  type = string
}

variable "azure_region" {
  type    = string
  default = "eastus"
}

# Variable pour definir le nom du groupe de ressource ou deployer la plateforme
# Variable Resource Group Name
variable "resource_group" {
  type    = string
  default = "K2Demo-RG"
}

variable "cluster_name" {
  type    = string
  default = "AKSK2"
}

variable "dns_name" {
  type    = string
  default = "aksk2"
}

variable "admin_username" {
  type    = string
  default = "aksadmin"
}

variable "ssh_key" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.13.5"
}


variable "agent_pools" {
  default = [
    {
      name            = "pool1"
      count           = 1
      vm_size         = "Standard_D1_v2"
      os_type         = "Linux"
      os_disk_size_gb = "30"
    },
    {
      name            = "pool2"
      count           = 2
      vm_size         = "Standard_D2_v2"
      os_type         = "Linux"
      os_disk_size_gb = "30"
    }
  ]
}
