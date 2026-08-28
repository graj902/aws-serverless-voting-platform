output "table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.votes.name
}

output "table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = aws_dynamodb_table.votes.arn
}

output "gsi_name" {
  description = "The name of the destination index"
  value       = [for gsi in aws_dynamodb_table.votes.global_secondary_index : gsi.name if gsi.name == "destination-index"][0]
}
