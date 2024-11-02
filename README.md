# Linode, Akamai GTM, and Locust Load Testing Setup

This repository contains Terraform and Locust configurations to deploy and test a scalable infrastructure with Linode instances, Akamai Global Traffic Management (GTM) configuration, and load testing using Locust. The setup is organized to allow provisioning of resources in the following order:

1. **Linode Instances and NodeBalancers**  
2. **Akamai GTM Configuration**  
3. **Locust Load Testing on Linode Kubernetes Engine (LKE)**

## Repository Structure

```plaintext
.
├── LICENSE
├── gtm
│   ├── README.md
│   ├── gtm.tf
│   ├── terraform.tf
│   └── variables.tf
├── linode
│   ├── README.md
│   ├── instances.tf
│   ├── terraform.tf
│   └── variables.tf
└── locust
    ├── README.md
    └── locustfile.py
```

Each subdirectory contains specific resources for provisioning and configuring parts of the infrastructure.

- **`linode/`**: Configures Linode instances and NodeBalancers using Terraform. Follow the README in this directory to deploy application servers and set up load balancers on Linode.
- **`gtm/`**: Configures Akamai GTM with Terraform to manage global traffic across the Linode NodeBalancers. This directory’s README provides details for setup and usage.
- **`locust/`**: Contains the Locust load testing script (`locustfile.py`) and instructions for deploying Locust on Linode Kubernetes Engine (LKE) using Helm. Refer to this directory’s README to run load tests on the infrastructure.

## Setup Guide

### 1. Provision Linode Resources

Start by provisioning Linode instances and NodeBalancers with the Terraform configurations in the `linode/` directory.

1. Navigate to the `linode/` directory.
   ```sh
   cd linode
   ```

2. Follow the instructions in the [Linode README](linode/README.md) to create the required instances and NodeBalancers.

### 2. Configure Akamai GTM

Once Linode resources are set up, configure Akamai GTM to manage traffic across the Linode NodeBalancers.

1. Navigate to the `gtm/` directory.
   ```sh
   cd ../gtm
   ```

2. Follow the instructions in the [GTM README](gtm/README.md) to configure GTM properties and data centers, linking to the Linode NodeBalancers.

### 3. Run Load Tests with Locust

Finally, deploy Locust on Linode Kubernetes Engine to simulate user traffic and assess the performance of the setup.

1. Navigate to the `locust/` directory.
   ```sh
   cd ../locust
   ```

2. Follow the instructions in the [Locust README](locust/README.md) to deploy Locust using Helm on LKE and run load tests against the infrastructure.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

## Support

For issues or questions, please open an issue in this repository or refer to individual README files for specific components.

