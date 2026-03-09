# Lab M3.04 - Deploy 3-Tier Application Architecture

## Overview
This lab implements a 3-tier application architecture on AWS with separate presentation, application, and data tiers.

## Architecture Summary
- **Tier 1 - Presentation:** Application Load Balancer in public subnets
- **Tier 2 - Application:** App servers in private subnets
- **Tier 3 - Data:** Database placeholder in private subnets

## Why 3-Tier Architecture?
A 3-tier architecture separates responsibilities across layers. This improves security, scalability, and maintainability by isolating presentation, application, and data services.

## Security Considerations
- The ALB accepts HTTP/HTTPS traffic from the internet
- App servers only accept traffic from the ALB security group
- Data tier only accepts MySQL/PostgreSQL traffic from the app tier security group
- Private subnets are used for app and data tiers

## Traffic Flow
1. Client sends request from the internet
2. Application Load Balancer receives the request in the public subnets
3. ALB forwards traffic to app servers in private subnets
4. App servers communicate with the database placeholder in the data subnets

## Future Improvements
- Replace database placeholder EC2 with Amazon RDS
- Add Auto Scaling Group for app tier
- Add HTTPS listener with ACM certificate
- Add CloudWatch alarms and monitoring
- Add bastion host or SSM Session Manager access

## Repository Structure
- `architecture/` → architecture documentation
- `config/` → deployed resource configuration
- `app/` → application and user data scripts
- `tests/` → testing and validation notes
