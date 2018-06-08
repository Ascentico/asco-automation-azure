#!/usr/bin/env bash

echo "Sourcing environment variables..."
source set_environment_variables.sh
source set_secure_environment_variables.sh

echo "Printing environment variables..."
#!/usr/bin/env bash set_environment_variables.sh

export TF_LOG=DEBUG

echo "Running terraform apply"
cd terraform
terraform init
terraform apply