variable "cluster_name" {
  description = "The name of kubernetes cluster"
  type        = string
}

variable "allowed_cidr" {
  description = "The IP address range of the Allowed IPs in this cluster. "
  type        = map(string)
}

variable "identity" {
  description = "The identity namespace."
  type        = string
}