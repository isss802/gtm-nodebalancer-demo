# Linode Instances and NodeBalancers Terraform Configuration

This repository contains Terraform code to provision Linode instances, set up NodeBalancers with HTTP configuration, and prepare them for integration with Akamai Global Traffic Management (GTM). This setup supports horizontal scaling and load balancing across multiple instances.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine
- Linode API token with permissions to create instances and NodeBalancers
- Valid Akamai GTM configuration if integration is required

## Configuration

The Terraform files in this setup define the following resources:

1. **Linode Instances**  
   Creates multiple Linode instances for application servers based on configurable parameters.

2. **NodeBalancers**  
   Sets up two NodeBalancers with HTTP (port 80) configurations to distribute traffic across the Linode instances.

3. **Node Attachments**  
   Attaches each Linode instance to the respective NodeBalancers, enabling load balancing across servers.

## Variables

The following variables should be configured to match your environment:

- `count_servers`: Number of Linode instances to create
- `node_type`: Linode instance type (e.g., `g6-standard-2`)
- `image`: Linode image ID (e.g., `linode/ubuntu20.04`)
- `region`: Linode region (e.g., `us-east`)
- `root_pass`: Root password for the Linode instances
- `firewall_id`: ID of the Linode firewall to use (optional)

These values can be set in a `variables.tf` file or provided through a `.tfvars` file.

## Usage

1. **Clone the repository**  
   ```sh
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
   ```

2. **Initialize Terraform**  
   Run the following command to initialize the required Terraform plugins:
   ```sh
   terraform init
   ```

3. **Plan the deployment**  
   Review the resources that Terraform will create:
   ```sh
   terraform plan
   ```

4. **Apply the configuration**  
   Deploy the resources with:
   ```sh
   terraform apply
   ```

## Resource Details

- **Linode Instances**  
  - Creates `count_servers` number of instances with private IPs for internal communication.
  - Labels each instance in sequence (e.g., `linode-gtm-1`, `linode-gtm-2`, etc.).
  - Tags the instances with `gtm` for easy identification.

- **NodeBalancers**  
  - Two NodeBalancers (`http-balancer-1` and `http-balancer-2`) are created for HTTP load balancing.
  - Each NodeBalancer listens on port 80 and is configured with no client connection throttling.

- **Node Attachments**  
  - Attaches each instance as a node to both NodeBalancers to balance traffic across the instances.
  - Nodes are labeled sequentially (e.g., `app-node-1`, `app-node-2`, etc.).
  - Each instance's private IP is used for communication over port 80.

## Example `.tfvars` File

Create a `.tfvars` file with your values to use with the configuration:

```hcl
count_servers = 2
node_type     = "g6-standard-2"
image         = "linode/ubuntu20.04"
region        = "us-east"
root_pass     = "your-secure-password"
firewall_id   = "your-firewall-id" # Optional
```

## License

MIT License

---

## Support

For issues or questions, please open an issue in this repository.

