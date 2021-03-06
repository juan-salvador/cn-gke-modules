
resource "google_container_node_pool" "primary_nodes" {
  cluster = var.cluster_name
  location = "us-central1-c"

  autoscaling {
    min_node_count = var.min_count_nodes
    max_node_count = var.max_count_nodes
  }

  node_count = 1

  management {
    auto_repair = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }
  
  name = "nodo-1"

  node_config {
    image_type = "COS"
    machine_type = "e2-medium"
    disk_type = "pd-standard"
    disk_size_gb = 100
    preemptible  = false
    service_account = "default"

    oauth_scopes = [
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]

    workload_metadata_config {
      node_metadata = "GKE_METADATA_SERVER" 
    }
  }
}