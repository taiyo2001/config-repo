terraform {
  required_version = "~> 1.15"

  cloud {
    organization = "taiyo2001"
    workspaces {
      name = "dotfiles"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}
