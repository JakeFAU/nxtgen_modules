provider "aws" {
  region = var.aws_region
}


resource "null_resource" "pip" {
  triggers = {
    requirements = base64sha256(file("src/requirements.txt"))
  }

  provisioner "local-exec" {
    command = "pip3 install -r ${path.module}/src/requirements.txt -t ${path.module}/src/python"
  }
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/lambda_layer.zip"

  depends_on = [null_resource.pip]
}

resource "aws_s3_object" "file_upload" {
  bucket = var.lambda_layer_bucket
  key    = "lambda-layers/${var.layer_name}"
  source = data.archive_file.source.output_path

  depends_on = [data.archive_file.source]
}

resource "aws_lambda_layer_version" "lambda_layer" {

  layer_name               = var.layer_name
  compatible_runtimes      = ["python3.9"]
  compatible_architectures = [var.arch]
  description              = "A nice lambda layer stored on S3"
  s3_bucket                = var.lambda_layer_bucket
  s3_key                   = "lambda-layers/${var.layer_name}"
  source_code_hash         = base64sha256(file("src/requirements.txt"))

  depends_on = [aws_s3_object.file_upload]
}

