#!/bin/bash
function TerraformImport() {
    domain_replace=$(echo ${domain}|sed 's/\./_/g')
    echo terraform import module.dns-${domain_replace}.module.domain.alicloud_dns.this[0] ${domain}
#    terraform import module.dns-${domain_replace}.module.domain.alicloud_dns.this[0] ${domain}
    
    echo "record_list=[" > ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
    cat /dev/null > ${temp_domain_file}
    for((i=1;i<=2;i++));
    do
        aliyun alidns DescribeDomainRecords --PageSize=500 --PageNumber ${i} --DomainName=${domain} | jq -r '.DomainRecords.Record' |jq .[].RecordId | sed 's/"//g' >> ${temp_domain_file}
#        lists=$(aliyun alidns DescribeDomainRecords --PageSize=500 --PageNumber ${j} --DomainName=${domain} | jq -r '.DomainRecords.Record' |jq .[].RecordId | sed 's/"//g')
    done
    lists=$(cat ${temp_domain_file})
    j=0
    for list in $lists
    do
        echo terraform import module.dns-${domain_replace}.module.records.alicloud_dns_record.this[${j}] ${list}
        terraform import module.dns-${domain_replace}.module.records.alicloud_dns_record.this[${j}] ${list}
        echo terraform state show -no-color module.dns-${domain_replace}.module.records.alicloud_dns_record.this[${j}] >> ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
        terraform state show -no-color module.dns-${domain_replace}.module.records.alicloud_dns_record.this[${j}] >> ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
        j=$(($j+1))
    done
    #terraform show -no-color |grep -A12 module.dns-${domain_replace}.module.records.alicloud_dns_record.this >> ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
    #sed -i '/--/d' ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
    sed -i '/#/d' ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
    sed -i '/id          =/d' ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
    sed -i '/locked      =/d' ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
    sed -i '/name        =/d' ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
    sed -i '/status      =/d' ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
    sed -i 's/}/},/g' ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
    sed -i 's/.*{/{/g' ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
    sed -i '$a]' ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
}

basepath=$(cd $(dirname $0); pwd)
source ${basepath}/../common.sh
cd ${basepath}
cd ../../${GLOABL_PATH}
for domain in ${DOMAIN_LIST}
do
    temp_domain_file=/tmp/dns-${domain}
    TerraformImport ${domain}
done
