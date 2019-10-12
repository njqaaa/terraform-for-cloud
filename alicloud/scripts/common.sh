#!/bin/bash

function checkStatus() {
    if [[ $? -ne 0 ]];then
        echo error
        exit 1
    fi
}

VPC_VAR_FILE="variables/vpc/vpc.tfvars"
VPC_VAR_PATH="variables/vpc"
SG_VAR_PATH="variables/sg"
ECS_VAR_PATH="variables/ecs"
SLB_VAR_PATH="variables/slb"
VARIABLES_PATH="variables"
GLOABL_PATH="gloabl"
DOMAIN_LIST="hfjy123.com hfjy.com hfjystudy.com hfjy.top"
