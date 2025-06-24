resource "google_compute_instance" "default" {
  name         = var.vm_name
  machine_type = "e2-medium"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id
  }
}


output "vm_internal_ip" {
  value = google_compute_instance.default.network_interface[0].network_ip
}