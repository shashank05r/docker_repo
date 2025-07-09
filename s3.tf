resource "aws_s3_bucket" "web_image_r2" {

    bucket="web-page-bucket-ncpl-r2"
    
  tags={

    Name= "s3webimage"

  }
}
# REQUIRED: Set Object Ownership to allow public access via policy
resource "aws_s3_bucket_ownership_controls" "web_image_r2" {
  bucket = aws_s3_bucket.web_image_r2.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# DISABLE BLOCKING PUBLIC ACCESS
resource "aws_s3_bucket_public_access_block" "web_image" {
  bucket = aws_s3_bucket.web_image_r2.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# PUBLIC ACCESS POLICY FOR STATIC FILES (images, html, etc.)
resource "aws_s3_bucket_policy" "web_image" {
  bucket = aws_s3_bucket.web_image_r2.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.web_image_r2.arn}/*"
      }
    ]
  })
}
