# security-test.md

## Security Validation
- Database tier should not be reachable directly from the internet
- Application tier should not be directly exposed to the internet
- ALB should be the only public entry point
- Data tier should accept connections only from app-tier security group
