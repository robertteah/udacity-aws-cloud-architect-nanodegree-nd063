provider "aws" {
  region                  = var.aws_region
}

data "archive_file" "archive" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "greet_lambda.zip"
}

# IAM role which dictates what other AWS services the Lambda function
 # may access.
resource "aws_iam_role" "i_am_greet_lambda" {
   name = "i_am_greet_lambda"

   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_lambda_function" "lambda_greeting" {
  role             = aws_iam_role.i_am_greet_lambda.arn
  filename         = "greet_lambda.zip"
  source_code_hash = data.archive_file.archive.output_base64sha256
  function_name    = var.lambda_function_name
  handler          = "${var.lambda_function_name}.lambda_handler"
  runtime          = "python3.8"

  environment {
    variables = {
      greeting = "Hello AWS!!"
    }
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_logs]
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.i_am_greet_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}