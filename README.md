# terraform_sns_topic

Terraform module to create SNS topics.

## Dependencies

KMS <https://github.com/virsas/terraform_kms>

## Terraform example

``` terraform
##################
# SNS topic
##################
module "sns_topic_alarms" {
  source = "github.com/virsas/terraform_sns_topic"
  name = "alarms"
  kms = module.kms-sns.arn
}
```

## Policies

You require to create two polices located in ./json/sns directory

### Access policy

``` bash
# Path 
./json/sns/access/NAME.json
```

Name is the same as the name of the SNS topic

``` JSON
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws:sns:eu-west-1:123456789012:alarms",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "123456789012"
        }
      }
    }
  ]
}
```

123456789012 is the ID of your account.

### Delivery policy

``` bash
# Path 
./json/sns/delivery/NAME.json
```

Name is the same as the name of the SNS topic

``` JSON
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false
  }
}
```

You can play with the configuration as per your needs.
