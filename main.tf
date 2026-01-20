terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "ubuntu_server" {
  name         = "ubuntu:latest"
  keep_locally = true
}

resource "docker_container" "simulated_server" {
  image = docker_image.ubuntu_server.image_id
  name  = "serveur-devoir-devops"
  start = true
}
