variable "region"{
  type = string
  default = "ap-south-1"
}

variable "db_password"{
  type = string
  sensitive = true
  default = "SomeSecurePassword123"
}
