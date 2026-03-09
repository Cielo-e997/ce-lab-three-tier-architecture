# NETWORK-DESIGN.md

## Network Design
The architecture uses separate subnet groups for each tier.

## VPC
- CIDR: 10.0.0.0/16

## Subnet Plan

### Public Subnets
- public-subnet-1a: 10.0.1.0/24
- public-subnet-1b: 10.0.2.0/24

### Application Private Subnets
- app-subnet-1a: 10.0.11.0/24
- app-subnet-1b: 10.0.12.0/24

### Data Private Subnets
- data-subnet-1a: 10.0.21.0/24
- data-subnet-1b: 10.0.22.0/24

## Routing
- Public subnets route internet-bound traffic through an Internet Gateway
- Private application and data subnets use a NAT Gateway for outbound internet access when needed
- Internal communication between tiers happens inside the VPC

## Segmentation Rationale
Network segmentation isolates each tier and reduces exposure. Public access is limited to the ALB, while application and data resources remain in private networks.
