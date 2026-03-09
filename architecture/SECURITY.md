# SECURITY.md

## Security Group Design

### 1. ALB Security Group
Purpose:
- Accept traffic from the internet

Rules:
- Inbound TCP 80 from 0.0.0.0/0
- Inbound TCP 443 from 0.0.0.0/0

### 2. App Tier Security Group
Purpose:
- Accept traffic only from the ALB

Rules:
- Inbound TCP 80 from ALB security group
- Inbound TCP 443 from ALB security group

### 3. Data Tier Security Group
Purpose:
- Accept database traffic only from the application tier

Rules:
- Inbound TCP 3306 from app-tier security group
- Inbound TCP 5432 from app-tier security group

## Security Rationale
This design enforces least privilege by allowing only required tier-to-tier communication. The database is never exposed directly to the internet, and application servers are not directly internet-accessible.

## Improvements
- Add HTTPS with ACM
- Restrict outbound rules further
- Use IAM roles for EC2
- Use SSM instead of SSH
