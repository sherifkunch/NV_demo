resource "aws_s3_bucket" "nv_s3_bucket" {
  bucket = "s3-website-nv.com"
  acl    = "public-read"
  policy = file("website-files/policy.json")
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
}
}

resource "aws_s3_bucket_object" "index" {
  bucket       = "s3-website-nv.com"  
  key          = "index.html"
  source       = "website-files/index.html"
  content_type = "text/html"
  force_destroy = true

  depends_on = [
    aws_s3_bucket.nv_s3_bucket,
  ]
}

resource "aws_s3_bucket_object" "error" {
  bucket       = "s3-website-nv.com"
  key          = "error.html"
  source       = "website-files/error.html"
  content_type = "text/html"
  force_destroy = true
  
  depends_on = [
    aws_s3_bucket.nv_s3_bucket,
  ]
}
