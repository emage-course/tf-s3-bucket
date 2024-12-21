#module "s3_bucket" {
#  source = "terraform-aws-modules/s3-bucket/aws"

resource "aws_s3_bucket" "mybucket" {
  bucket = "terraform-bucket-lab1"
  acl    = "private" # or can be "public-read"

  tags = {
    Name        = "my-bucket"
    Environment = "Dev"
  }
}

# Upload single object
resource "aws_s3_object" "single_file" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "./upload/demo.txt"
  acl    = "private" # or can be "public-read"
  source = "./upload/demo.txt"
}

# To upload multiple files (optional)
resource "aws_s3_object" "demo" {
  #  for_each      = fileset("./documents/", "**/*.*")
  for_each = fileset("./documents/", "**")
  bucket   = aws_s3_bucket.mybucket.id
  key      = each.value
  acl      = "private" # or can be "public-read"
  source   = "./documents/${each.value}"
  etag     = filemd5("./documents/${each.value}")
}

/* # Use a local-exec provisioner with AWS CLI to run aws s3 cp.
resource "null_resource" "s3_objects1" {
  provisioner "local-exec" {
    command = "aws s3 cp ./upload/demo1.txt s3://aws_s3_bucket.mybucket.id --recursive"
  }
}

# Use a local-exec provisioner with AWS CLI to run aws s3 sync.
resource "null_resource" "s3_objects2" {
  provisioner "local-exec" {
    command = "aws s3 sync ./upload/demo2.txt s3://aws_s3_bucket.mybucket.id --recursive"
  }
} */
