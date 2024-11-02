# Akamai GTM Terraform Configuration

This repository contains Terraform code to configure an Akamai GTM (Global Traffic Management) setup. This configuration allows setting up a GTM domain with multiple data centers and properties for load balancing and liveness testing. The GTM domain is configured to use weighted load balancing with specified data centers and traffic targets.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine
- Akamai credentials with permissions to manage GTM configurations
- Valid Akamai Contract and Group IDs

## Configuration

The Terraform files in this setup define the following resources:

1. **GTM Domain**  
   Defines the GTM domain with weighted load balancing and email notification settings.

2. **GTM Data Centers**  
   Configures data centers used for traffic routing. In this example, two data centers, `linode-osa-1` and `linode-osa-2`, are configured.

3. **GTM Property**  
   Sets up a property with weighted-round-robin load balancing between the defined data centers. Configures a liveness test for monitoring endpoint health.

## Variables

The following variables are required:

- `gtm_name`: Name of the GTM domain.
- `contract_id`: Akamai contract ID.
- `group_id`: Akamai group ID.
- `nb-1`: IP or hostname for the server in `linode-osa-1` data center.
- `nb-2`: IP or hostname for the server in `linode-osa-2` data center.

Update the `variables.tf` file or provide values through a `.tfvars` file.

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
   Review the changes Terraform will apply:
   ```sh
   terraform plan
   ```

4. **Apply the configuration**  
   Deploy the resources with:
   ```sh
   terraform apply
   ```

## Resource Details

- **GTM Domain**  
  - Name: Set by `gtm_name` variable
  - Type: Weighted load balancing with 10% imbalance tolerance
  - Notification and wait settings as defined in the configuration

- **GTM Data Centers**  
  - Two data centers, `linode-osa-1` and `linode-osa-2`, with wait disabled.

- **GTM Property**  
  - Type: Weighted round-robin load balancing
  - Liveness Test: HTTP test to monitor availability of the servers

## Liveness Test Configuration

The liveness test checks server health every 10 seconds using HTTP. It checks for errors (3xx, 4xx, and 5xx) and uses a standard port 80.

---

## Example `.tfvars` File

Create a `.tfvars` file with your values to use with the configuration:

```hcl
gtm_name      = "your-gtm-domain"
contract_id   = "your-contract-id"
group_id      = "your-group-id"
nb-1          = "server-address-1"
nb-2          = "server-address-2"
```

## License

MIT License

---

## Support

For issues or questions, please open an issue in this repository.

