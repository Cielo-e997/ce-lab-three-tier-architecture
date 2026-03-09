# ARCHITECTURE.md

## Detailed Architecture
This solution uses a 3-tier architecture deployed in AWS across multiple subnets.

### Tier 1 - Presentation
- Internet-facing Application Load Balancer
- Deployed in public subnets
- Receives HTTP traffic from users

### Tier 2 - Application
- EC2 application servers
- Deployed in private subnets
- Process requests forwarded by the ALB
- Expose `/health` and `/api/stats`

### Tier 3 - Data
- EC2 database placeholder instance
- Deployed in private data subnet
- Simulates database services on ports 3306 and 5432

## Reflection Questions

### Why separate application and database tiers?
Separating tiers improves security and reduces direct exposure of sensitive systems. The database should only be reachable by trusted application servers.

### What are the security benefits of this architecture?
Each tier has its own security group and subnet placement, which reduces lateral movement and limits access only to required components.

### How does traffic flow from internet to database?
Traffic flows from the internet to the ALB, then from the ALB to app servers, and finally from the app servers to the data tier.

### What happens if one availability zone fails?
If one AZ fails, the ALB can continue routing traffic to healthy instances in the remaining AZ, improving availability.

### How would you scale each tier independently?
The presentation tier can scale by ALB-managed distribution, the application tier by adding/removing EC2 instances, and the data tier by replacing the placeholder with a managed scalable database service.

### What are the trade-offs of 3-tier vs monolith?
A 3-tier design improves isolation and scalability but is more complex to deploy, manage, and troubleshoot than a monolithic architecture.
