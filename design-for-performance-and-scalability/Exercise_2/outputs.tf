# TODO: Define the output variable for the lambda function.
output "lambda_function_id" {
  value = "${aws_lambda_function.lambda_greeting.id}"
}