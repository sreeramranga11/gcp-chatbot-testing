resource "google_compute_instance_template" "livestream_template" {
  name_prefix = "livestream-template-"
  # Configure your instance template here, including changes like image, machine type, etc.
  # Example:
  machine_type = "e2-medium"
  disk {
    source_image = "debian-cloud/debian-11"
    disk_size_gb = 20
  }
  network_interface {
    network = "default"
  }
}

resource "google_compute_instance_group_manager" "livestream_mig" {
  name = "livestream-mig"
  base_instance_name = "livestream-instance"
  version {
    instance_template = google_compute_instance_template.livestream_template.id
  }
  # Optionally, specify update policy for rolling updates.
  update_policy {
    type = "ROLLING_UPDATE"
    minimal_action = "RESTART"
    max_surge_fixed = 1
  }
}