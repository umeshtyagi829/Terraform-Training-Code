provider "google"{
    project = "arthfirstproject1"
    region = "asia-south1" 
    credentials = "arthfirstproject1.json"
}

resource "google_compute_instance" "default" {
  name         = "os1"
  machine_type = "e2-medium"
  zone         = "asia-south1-c"

boot_disk {
  initialize_params {
    image = "debian-cloud/debian-9"
   }
  }

network_interface {
  network = "default"
  }
}