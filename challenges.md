Challenges & Resolutions:

-->Challenge: ECS TaskRoleArn & ExecutionRoleArn confusion

Issue: Terraform returns two separate roles; GitHub deploy action requires both.
Solution: Export roles via Terraform outputs & reference in taskdef.json.

-->Challenge: Permission denied while pushing image to ECR

Cause: Missing IAM permissions for GitHub Actions.
Fix: Attached policy: AmazonEC2ContainerRegistryFullAccess

-->Challenge: ALB health checks failing

Cause: Container listening on 5000 but health checks default to /.
Fix: Updated container + ALB target group path: /.

-->Challenge: RDS connection refused

Cause: Security group not allowing ECS → RDS traffic.
Fix: Added SG rule:
source = ecs_service_sg.id
port   = 5432

-->Challenge: Terraform state locking issue

Cause: DynamoDB table missing primary key.
Fix: Added table with:
Partition Key: LockID (String)

