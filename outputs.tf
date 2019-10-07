
output "arn" {
  value       = aws_iam_user.user.arn
  description = "The ARN of IAM User"
}
