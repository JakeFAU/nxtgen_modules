provider "aws" {
  region = var.aws_region
}


resource "null_resource" "pip" {
  triggers {
    requirements = base64sha256(file("src/requirements.txt"))
  }

  provisioner "local-exec" {
    command = "pip3 -r ${path.module}/src/requirements.txt"
  }
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/lambda_layer.zip"

  depends_on = [null_resource.pip]
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket = var.lambda_layer_bucket
  key    = "lambda-layers/${var.layer_name}"
  source = data.archive_file.source.output_path
}

resource "aws_lambda_layer_version" "lambda_layer" {

  layer_name          = var.layer_name
  compatible_runtimes = ["python3.9"]
  description         = "A nice lambda layer stored on S3"
  s3_bucket           = var.lambda_layer_bucket
  s3_key              = "lambda-layers/${var.layer_name}"
  source_code_hash    = filebase64sha256(data.archive_file.source.output_path)
}

