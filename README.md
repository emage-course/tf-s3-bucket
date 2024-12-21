

AWS S3
____________________________________________
AWS S3 is a scalable, high-speed, web-based cloud storage service designed for online backup and archiving of data and applications on AWS. It allows for the storage and retrieval of any amount of data, at any time, from anywhere on the web.


Create and Manage an AWS S3 Bucket Using Terraform
____________________________________________
**Step 1**: Create a Terraform Configuration File for the provision of an s3 bucket.

```
$ vim s3_bucket.tf 
```

**Step 2**: Define the Files to Upload

**Step 3**: Finally to execute terraform apply and see the output.
Finally to execute terraform apply and see the output.

```
$ terraform init
$ terraform plan
$ terraform apply
```

**Step 4**: After completion of the above steps, run "aws s3 ls" or log in to the AWS console to verify. 
```
$ aws s3 ls # To get the list of all buckets.
$ aws s3 ls s3://bucket-name # Will list all the files in the bucket 
$ aws s3 rb s3://bucket-name --force # Will delete all the objects and the folders/sub-folders 
``` 

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "${local.env}-${local.project}-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.region}"
    encrypt        = true
    dynamodb_table = "${local.project}-lock-table"
  }
}
