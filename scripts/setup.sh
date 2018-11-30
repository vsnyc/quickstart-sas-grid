#ws --region "us-east-1" ssm put-parameter --name "sas-grid-ansiblekey-!/usr/bin/env bash

set -e
set -x


#
# create and distribute key
#
echo -e y | ssh-keygen -t rsa -q -f ~/.ssh/id_rsa -N ""

KEY=$(cat ~/.ssh/id_rsa.pub)

PARENT_STACK_ID=$(aws --region "{{AWSRegion}}" cloudformation describe-stacks --stack-name "{{CloudFormationStack}}" --query 'Stacks[].ParentId' --output text)
PARENT_STACK_NAME=$(aws --region "{{AWSRegion}}" cloudformation describe-stacks --stack-name "$PARENT_STACK_ID" --query 'Stacks[].StackName' --output text)
LUSTRE_STACK_ID=$(aws --no-paginate --region "{{AWSRegion}}" cloudformation describe-stack-resources --stack-name "$PARENT_STACK_NAME" --logical-resource-id "LustreStack" --query 'StackResources[*].PhysicalResourceId' --output text)
LUSTRE_STACK_NAME=$(aws --no-paginate --region "{{AWSRegion}}" cloudformation describe-stacks --stack-name "$LUSTRE_STACK_ID" --query 'Stacks[].StackName' --output text)

aws --region "{{AWSRegion}}" ssm put-parameter --name "sas-grid-ansiblekey-${PARENT_STACK_NAME}" --type String --value "$KEY" --overwrite
aws --region "{{AWSRegion}}" ssm put-parameter --name "sas-grid-ansiblekey-${LUSTRE_STACK_NAME}" --type String --value "$KEY" --overwrite

#
# install ansible
#
sudo pip install 'ansible==2.4.3'
