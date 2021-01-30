resource "google_container_cluster" "cn_gke" {

  name = var.cluster_name
  location = "us-central1-c"
  min_master_version = "1.16.15-gke.6000"
  node_version = "1.16.15-gke.6000"

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "10.41.0.0/28"
  }

  network = "vpc-cn"
  subnetwork = "dev"

  ip_allocation_policy {
    cluster_ipv4_cidr_block = "10.42.0.0/16"
    services_ipv4_cidr_block = "10.43.0.0/16"
  }

  addons_config {
    http_load_balancing {
        disabled = false
    }
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.allowed_cidr
      content {
        cidr_block = cidr_blocks.value
        display_name = cidr_blocks.key
      }
    }
  }

  workload_identity_config {
    identity_namespace = var.identity
  }

  description = "cluster gke"

  remove_default_node_pool = true
  initial_node_count       = 1

  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}

output "cluster_name" {
  value = google_container_cluster.cn_gke.name
  description = "cluster name that has been created"
}