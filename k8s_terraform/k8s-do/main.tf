terraform {
  backend "s3" {
    bucket = "descomplicando-terraform-arielson" //bucket's name
    key    = "terraform-test-tf.state" //bucket aws
    region = "us-east-1"               //bucket region
  }
}

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.DO_TOKEN
}


