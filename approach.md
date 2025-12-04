Approach & Architectural Decision Document

This document explains the reasoning behind each technical component used in this assignment.

-->Why ECS Fargate?

No servers to manage
Autoscaling built-in
Perfect for containerized applications
Stateless deployment pattern
Lower operational overhead than EC2 or EKS
Startup-friendly and cost-efficient

-->Why Private RDS?

Databases should never be public
Reduced attack surface
Only ECS tasks can access DB
Follows security best practices for PCI/SOC2/GDPR
Recommended in production workloads

-->Why Terraform?

Infrastructure-as-Code ensures:
reproducibility
version control
consistent deployments
Module-based approach allows future expansion
Remote S3 state improves collaboration

-->Why GitHub Actions?

Native integration with GitHub
Easy-to-manage workflows
Supports manual approvals
Built-in secret storage
Cost-free for public repos

-->Why Trivy for security scanning?

Lightweight
Integrates easily with CI
Performs both filesystem and container scanning
Detects CVEs early

-->Monitoring Choices

CloudWatch is native to AWS
ECS, ALB, RDS all have built-in metrics
Dashboards provide a single-pane-of-glass
Logs centralized for debugging
