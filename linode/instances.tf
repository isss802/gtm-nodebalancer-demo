# インスタンス作成
resource "linode_instance" "app_servers" {
  count = var.count_servers
  type  = var.node_type
  image = var.image
  region = var.region
  label = "linode-gtm-${count.index + 1}"
  root_pass = var.root_pass
  tags = ["gtm"]
  firewall_id = var.firewall_id
  interface {
    purpose = "public"
  }
  private_ip = true
}

# NodeBalancer 2つ作成
resource "linode_nodebalancer" "http_balancer_1" {
  region = var.region
  label  = "http-balancer-1"
  client_conn_throttle = 0
}

resource "linode_nodebalancer" "http_balancer_2" {
  region = var.region
  label  = "http-balancer-2"
  client_conn_throttle = 0
}

# NodeBalancerのHTTPポート80の設定
resource "linode_nodebalancer_config" "http_config_1" {
  nodebalancer_id = linode_nodebalancer.http_balancer_1.id
  port            = 80
  protocol        = "http"
}

resource "linode_nodebalancer_config" "http_config_2" {
  nodebalancer_id = linode_nodebalancer.http_balancer_2.id
  port            = 80
  protocol        = "http"
}

# サーバーをNodeBalancerにアタッチ
resource "linode_nodebalancer_node" "app_nodes" {
  count = var.count_servers
  nodebalancer_id = linode_nodebalancer.http_balancer_1.id
  label           = "app-node-${count.index + 1}"
  address         = "${linode_instance.app_servers[count.index].private_ip_address}:80"
  config_id       = linode_nodebalancer_config.http_config_1.id
}

resource "linode_nodebalancer_node" "app_nodes_2" {
  count = var.count_servers
  nodebalancer_id = linode_nodebalancer.http_balancer_2.id
  label           = "app-node-${count.index + 1}"
  address         = "${linode_instance.app_servers[count.index].private_ip_address}:80"
  config_id       = linode_nodebalancer_config.http_config_2.id
}
