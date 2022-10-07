terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "build" {
  name = "build:latest"
  build {
    path = "../"
  }
  keep_locally = false
}

resource "docker_container" "container" {
  image = docker_image.build.latest
  name  = "container"
  ports {
    internal = 80
    external = 8000
  }
}
