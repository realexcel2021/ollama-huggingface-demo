variable "resource_group_location" {
  type = string
  default = "East US"
}

variable "resource_group_name" {
  type = string
  default = "ai-workload-rg"
}

variable "project_name" {
  type = string
  default = "ai-workload"   
  
}

variable "standard_node_count" {
  type    = number
  default = 1
}

variable "gpu_node_count" {
  type    = number
  default = 1   
}