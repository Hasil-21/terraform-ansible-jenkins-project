terraform{
  required_providers{
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
	
    local = {
      source = "hashicorp/local"
      version = "~> 2.0"
    }
  }
  
  backend "s3"{
    bucket = "hasil-terraform-state-2026"
    key = "jenkins-mini-project/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}


provider "aws"{
  region = var.region
}
