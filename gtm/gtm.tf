resource "akamai_gtm_domain" "linode_gtm" {
  name = var.gtm_name
  type = "weighted"
  contract                  = var.contract_id
  group                     = var.group_id
  email_notification_list   = []
  load_imbalance_percentage = 10
  // Required
  wait_on_complete = false
}

resource "akamai_gtm_datacenter" "linode-osa-1" {
  domain           = akamai_gtm_domain.linode_gtm.name
  nickname         = "linode-osa-1"
  wait_on_complete = false
}

resource "akamai_gtm_datacenter" "linode-osa-2" {
  domain           = akamai_gtm_domain.linode_gtm.name
  nickname         = "linode-osa-2"
  wait_on_complete = false
}


resource "akamai_gtm_property" "linode" {
  domain                      = akamai_gtm_domain.linode_gtm.name
  name                        = "gtm"
  type                        = "weighted-round-robin"
  ipv6                        = false
  score_aggregation_type      = "median"
  stickiness_bonus_percentage = 0
  stickiness_bonus_constant   = 0
  use_computed_targets        = false
  balance_by_download_score   = false
  dynamic_ttl                 = 30
  handout_limit               = 8
  handout_mode                = "normal"
  failover_delay              = 0
  failback_delay              = 0
  ghost_demand_reporting      = false
  comments                    = "demo"
  traffic_target {
    datacenter_id = akamai_gtm_datacenter.linode-osa-1.datacenter_id
    enabled       = true
    weight        = 1
    servers       = [var.nb-1]
  }
  traffic_target {
		datacenter_id = akamai_gtm_datacenter.linode-osa-2.datacenter_id
    enabled       = true
    weight        = 1
    servers       = [var.nb-2]
  }
  liveness_test {
    name                             = "HTTP Load Test"
    peer_certificate_verification    = false
    test_interval                    = 10
    test_object                      = "/"
    http_error3xx                    = true
    http_error4xx                    = true
    http_error5xx                    = true
    disabled                         = false
    test_object_protocol             = "HTTP"
    test_object_port                 = 80
    disable_nonstandard_port_warning = true
    test_timeout                     = 5
    answers_required                 = false
    recursion_requested              = false
  }
}  
 
