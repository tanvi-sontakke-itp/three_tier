**Three Tier Architecture in Azure**

This project provisions a secure, production-style three-tier architecture on Microsoft Azure using Terraform Infrastructure as Code (IaC). The architecture follows cloud security best practices, implements defense-in-depth, and demonstrates secure networking, private database connectivity, and scalable application infrastructure.

The system consists of:

1. Frontend Layer: Azure Application Gateway with Web Application Firewall (WAF)
2. Application Layer: Virtual Machine Scale Set (VMSS) running a Node.js backend
3. Data Layer: Azure PostgreSQL Flexible Server accessed through a Private Endpoint
4. Networking Layer: Virtual Network with segmented subnets, NSGs, NAT Gateway
5. Security & Secrets: Azure Key Vault
6. DNS: Public DNS for frontend access and Private DNS for database resolution
7. Storage: Azure Storage Account for blob storage

The deployment is fully automated using Terraform modules.