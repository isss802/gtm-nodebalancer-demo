variable "contract_id" {
  type = string
  default = "ctr_" # Contract ID
}

variable "group_id" {
  type = string
  default = "grp_" # Group ID
}

variable "gtm_name" {
  type = string
  default = ".akadns.net" # GTM Name
}

variable "nb-1" {
  type = string
  default = ".ip.linodeusercontent.com" # Linode NodeBalancer Endpoint
}

variable "nb-2" {
  type = string
  default = ".ip.linodeusercontent.com" # Linode NodeBalancer Endpoint
}
