# quickstart-sas-grid
## AWS Cloud Infrastructure for SAS Grid

This Quick Start deploys and configures the required infrastructure for SAS Grid software on the AWS Cloud.

SAS Grid is a shared, centrally managed analytics computing environment that features workload balancing and management, high availability, and fast processing. A SAS Grid environment in the AWS Cloud provides the elasticity and agility to scale your resources as needed.

This Quick Start bootstraps the infrastructure for a SAS Grid cluster by provisioning Amazon Elastic Compute Cloud (Amazon EC2) instances for SAS Grid, SAS Metadata Server, and SAS mid-tier components. It also sets up Intel Cloud Edition for Lustre, which provides a shared directory for the grid. After you deploy the Quick Start, you can obtain a SAS license and install SAS Grid directly into your configured environment.

The AWS CloudFormation templates included with the Quick Start automate the following:

- Deploying the SAS Grid infrastructure into a new VPC
- Deploying the SAS Grid infrastructure into an existing VPC 

You can also use the AWS CloudFormation templates as a starting point for your own implementation.

![Quick Start architecture for SAS Grid on AWS](https://d0.awsstatic.com/partner-network/QuickStart/datasheets/sas-grid-infrastructure-on-the-aws-cloud.png)

For architectural details, best practices, step-by-step instructions, and customization options, see the [deployment guide](https://s3.amazonaws.com/quickstart-reference/sas/grid/latest/doc/aws-cloud-infrastructure-for-sas-grid.pdf).

To post feedback, submit feature ideas, or report bugs, use the **Issues** section of this GitHub repo.
If you'd like to submit code for this Quick Start, please review the [AWS Quick Start Contributor's Kit](https://aws-quickstart.github.io/). 
