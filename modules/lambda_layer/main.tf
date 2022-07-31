provider "aws" {
  region = var.aws-region
}


module "lambda_layer_pip_requirements" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-lambda.git?rev=v3.3.1"

  create_function = false
  create_layer    = true

  layer_name          = var.layer_name
  compatible_runtimes = ["python3.9"]
  runtime             = "python3.9" # required to force layers to do pip install

  source_path = [
    {
      path             = "${path.module}/src/"
      pip_requirements = true
      prefix_in_zip    = "python" # required to get the path correct
    }
  ]

  tags = var.tags

}
