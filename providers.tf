terraform {
  required_providers {
    mist = {
      source  = "registry.terraform.io/Juniper/mist"
      version = "~> 0.2.6"
    }
  }
}

provider "mist" {
  host = "api.mist.com"
  #apitoken = "" # Not used here. MIST_API_TOKEN environment variable is used instead.
}