#!/bin/bash
basepath=$(cd $(dirname $0); pwd)
source ${basepath}/common.sh
cd ${basepath}
service=$1
cd ..
if [[ -z ${service} ]];then
    echo "please input xx"
    ls -l ${VARIABLES_PATH}| grep '^d' | awk '{print $NF}'
    exit 1
fi

var_path=${VARIABLES_PATH}/${service}/
for var_file in $(ls ${var_path} | grep ".tfvars")
do
    if [[ -f ${vpc_file} ]];then
        vpc_command="var-file=${VPC_VAR_FILE}"
    fi
    if [[ ${service} == "vpc" ]];then
        terraform apply ${vpc_command} -target=module.vpc
    else
        echo terraform apply ${vpc_command} -var-file=${VARIABLES_PATH}/${service}/${var_file} -target=$(echo ${var_file} | awk -F '.tfvars' '{print "module.'${service}'-"$1}')
        terraform apply ${vpc_command} -var-file=${VARIABLES_PATH}/${service}/${var_file} -target=$(echo ${var_file} | awk -F '.tfvars' '{print "module.'${service}'-"$1}')
    fi
    checkStatus
done
