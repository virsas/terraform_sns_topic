provider "aws" {
  region = var.region
}

resource "aws_sns_topic" "sns" {
  name              = var.name
  kms_master_key_id = var.kms
  policy            = file("./json/sns/access/${var.name}.json")
  delivery_policy   = file("./json/sns/delivery/${var.name}.json")
}