variable "name" {
  type        = string
  description = "Name of cluster"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix specified when creating the cluster"
}

variable "node_count" {
  type        = number
  description = "Initial number of nodes that should exist in node pool"
  default     = 2
}

variable "vm_size" {
  type        = string
  description = "The size of Virtual Machine"
  default     = "Standard_DS2_v2"
}
