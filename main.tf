resource "aws_sns_topic" "sns" {
  name              = var.name
  kms_master_key_id = var.kms
  policy            = file("json/sns_access/${var.name}.json")
  delivery_policy   = file("json/sns_delivery/${var.name}.json")
}