# OctaByte-AI--Devops-Assignment
Infrastructure | CI/CD | Monitoring | Documentation  This repository contains an end-to-end DevOps implementation designed for a highly available, containerized web application deployed on AWS ECS Fargate, with Terraform-based infrastructure, automated CI/CD pipelines, private RDS, monitoring, and centralized logging.

Architecture Overview:

                    ┌──────────────────────────────────────────────┐
                    │                  GitHub                      │
                    │                                              │
                    │  PR → Tests → Security Scan → Approval       │
                    │  Merge to Main → Build → Deploy → ECS        │
                    └──────────────────────────────────────────────┘
                                      |
                                      v
 ┌──────────────────────────────────────────────────────────────────────────┐
 |                             AWS Cloud                                    |
 |                                                                          |
 |  ┌────────────────────────────────────────────────────────────────────┐  |
 |  │                               VPC                                   │  |
 |  │                    (Public + Private Subnets)                       │  |
 |  │                                                                    │  |
 |  │  Public Subnets:         Private Subnets:                          │  |
 |  │  • ALB                   • ECS Fargate tasks                       │  |
 |  │                          • RDS PostgreSQL (private)                │  |
 |  │                                                                    │  |
 |  │  ┌──────────────┐                      ┌─────────────────────┐     │  |
 |  │  │  Application │ <───── ALB ───────→  │  ECS Service (app) │     │  |
 |  │  │ LoadBalancer │                      └─────────────────────┘     │  |
 |  │  └──────────────┘                                 |                │  |
 |  │                                                   v                │  |
 |  │                                        ┌──────────────────┐        │  |
 |  │                                        │   RDS PostgreSQL │        │  |
 |  │                                        └──────────────────┘        │  |
 |  └────────────────────────────────────────────────────────────────────┘  |
 └──────────────────────────────────────────────────────────────────────────┘

Part 1 — Infrastructure Provisioning (Terraform)

Terraform creates the following resources:
-->VPC
2 public subnets
2 private subnets
NAT Gateway
Internet Gateway

-->ECS Fargate
ECS Cluster
Task Definition
ECS Service with Load Balancer
Private networking (no public IPs on tasks)

-->Application Load Balancer
Public-facing listener (port 80)
Target Group (port 5000)

-->Private RDS PostgreSQL
db.t3.micro
Accessible only from ECS tasks
Inside private subnets
Encrypted storage

-->Security Groups
ALB → ECS traffic
ECS → RDS traffic
No public access to RDS

-->Remote State
Stored in
S3 bucket
DynamoDB table for locking

-->Outputs
ALB DNS URL
ECR repo URL

Part 2 — CI/CD (GitHub Actions)

Two workflows are included:

-->PR Checks Pipeline (pr-check.yml)
Runs on pull_request:

Install dependencies
Run unit tests
Lint Python code
Lint Dockerfile
Trivy filesystem scan
Trivy container scan

Ensures quality + security gates before merging.

-->Build & Deploy Pipeline (deploy.yml)
Triggered on push to main:

Build Docker image
Push to ECR
Deploy to staging ECS service
Wait for manual approval
Deploy to production ECS service
Slack/email notifications

Production deployment requires a human approval step.

Part 3 — Monitoring & Logging

-->CloudWatch Metrics

ECS CPU/Memory
RDS CPU, connections, free storage
ALB request count, latency, 5XX errors

-->Dashboards Provided

Infrastructure Dashboard
Application Health Dashboard

-->Logging

ECS application logs → CloudWatch Logs
System logs → CloudWatch
ALB Access Logs → S3
Log retention set to 14 days (configurable)

-->Security Considerations

RDS deployed in private subnets
Security groups enforce least privilege
ECS tasks run with IAM task roles
Private ECR access
GitHub secrets for AWS credentials
No hardcoded credentials in repo
Terraform remote state encrypted
Docker image scanning included

-->Cost Optimization

NAT Gateway: single (to reduce cost)
ECS Fargate autoscaling disabled for demo
RDS db.t3.micro (low-cost)
Use S3 lifecycle rules for logs
Stateless application architecture
ALB in two AZs for HA but minimal impact
