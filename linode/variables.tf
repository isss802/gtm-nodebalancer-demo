variable "token" {}

variable "region" {
  type    = string
  default = "jp-osa" # Linodeの希望するリージョンに変更可能
}

variable "image" {
  type    = string
  default = "linode/ubuntu24.04"
}

variable "node_type" {
  type    = string
  default = "g6-standard-2" # Linode 8 GB プラン
}

variable "count_servers" {
  type    = number
  default = 12
}

variable "firewall_id" {
  type    = string
  default = "" # Firewall ID
}

variable "root_pass" {
  type    = string
  default = "" #ルートパスワード
