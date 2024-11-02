# Locust Load Testing on Linode Kubernetes Engine

This repository contains a Locust load testing script (`locustfile.py`) designed to run on Linode Kubernetes Engine (LKE). This setup allows you to perform HTTP load testing against an endpoint, simulating user traffic to assess server performance.

## Prerequisites

- [Linode Kubernetes Engine (LKE)](https://www.linode.com/docs/guides/deploy-and-manage-kubernetes-clusters-with-linode-kubernetes-engine/) cluster set up and configured
- [Helm](https://helm.sh/docs/intro/install/) installed on your local machine
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) CLI configured to manage your LKE cluster

## Locust Script

The `locustfile.py` script contains a simple test case that sends GET requests to the `/dummy` endpoint.

### `locustfile.py` Example

In this example:
- Each simulated user repeatedly sends a GET request to `/dummy`.

## Deploying Locust on Linode Kubernetes Engine (LKE) with Helm

Using Helm simplifies the deployment of Locust to your Kubernetes cluster. Helm charts provide reusable configurations for deploying Locust with master and worker nodes.

1. **Add the Helm Repository for Locust**  
   Add a repository with Locust charts (if available) or download and customize the official Locust chart if using a custom repository.

   ```sh
   helm repo add deliveryhero https://charts.deliveryhero.io/
   helm repo update
   ```

2. **Prepare `locustfile.py` as a ConfigMap**  
   Create a ConfigMap for the `locustfile.py` file:

   ```sh
   kubectl create configmap locustfile --from-file=locustfile.py
   ```

3. **Deploy Locust using Helm**

   Use the following Helm command to deploy Locust on LKE, configuring the number of master and worker nodes as needed:

   ```sh
   helm install locust stable/locust \
     --set master.config.configMap=locustfile \
     --set master.service.type=LoadBalancer \
     --set worker.replicaCount=2
   ```

   In this command:
   - `master.config.configMap=locustfile`: Mounts the `locustfile.py` ConfigMap to the Locust master.
   - `master.service.type=LoadBalancer`: Exposes Locust’s web interface through a LoadBalancer IP.
   - `worker.replicaCount=2`: Sets the number of Locust worker nodes (adjust as needed).

4. **Access the Locust Web Interface**  
   Once deployed, get the external IP of the Locust master service to access the web interface:

   ```sh
   kubectl --namespace default port-forward service/locust 8089:8089
   ```

   Open the URL in a web browser to access Locust's web interface and start your load test.

## License

MIT License

---

## Support

For issues or questions, please open an issue in this repository.

