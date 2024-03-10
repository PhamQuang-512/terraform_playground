terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~>5.11.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "3.25.0"
    }
    # key: AoqJKxYmiVftAyeyEjNF5gzEyRtBPGQx9/BAgEPnFJw=
    # token: hvs.utJw9vBnTHM00fdPv6VNme6f
  }
  backend "gcs" {
    bucket  = "quangpham5-bucket"
    prefix  = "terraform/state"
  }
}

provider "google" {
  alias        = "tokengen"
}

data "google_service_account_access_token" "default" {
  provider               = google.tokengen
  target_service_account = "iac-project@vinid-playground.iam.gserviceaccount.com"
  scopes                 = ["cloud-platform"]
  lifetime               = "300s"
}

provider "google" {
  project = var.project
  region = var.region
  zone = var.zone
  access_token = data.google_service_account_access_token.default.access_token
}


provider "vault" {
  token = "hvs.utJw9vBnTHM00fdPv6VNme6f"
  skip_tls_verify = true
}