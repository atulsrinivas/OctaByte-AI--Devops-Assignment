output "alb_dns" {
  value = aws_lb.app_alb.dns_name
}

output "ecr_repository" {
  value = aws_ecr_repository.app_repo.repository_url
}
