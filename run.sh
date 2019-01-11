#!/bin/bash

echo "Start executing terraform script"

terraform init
terraform apply -auto-approve
terraform destroy -auto-approve

echo "Check results in folder /ansible/results"

