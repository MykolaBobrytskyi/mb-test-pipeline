variable "project" {}
variable "do_token" {}
variable "tags" {
  default = {
    "Environment" = "dev"
    "Project"     = "mb-test-pipeline"
  }
}
