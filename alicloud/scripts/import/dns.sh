#!/bin/bash
function TerraformImport() {
    domain_replace=$(echo ${domain}|sed 's/\./_/g')
    echo terraform import module.dns-${domain_replace}.module.domain.alicloud_dns.this[0] ${domain}
    terraform import module.dns-${domain_replace}.module.domain.alicloud_dns.this[0] ${domain}
    
    cat /dev/null > ${temp_domain_file}
    for((i=1;i<=2;i++));
    do
        aliyun alidns DescribeDomainRecords --PageSize=500 --PageNumber ${i} --DomainName=${domain} | jq -r '.DomainRecords.Record' >> ${temp_domain_file}
    done
    lists=$(cat ${temp_domain_file} | jq .[].RecordId | sed 's/"//g' )
    j=0
    for list in $lists
    do
        echo terraform import module.dns-${domain_replace}.module.records.alicloud_dns_record.this[${j}] ${list}
        terraform import module.dns-${domain_replace}.module.records.alicloud_dns_record.this[${j}] ${list}
        j=$(($j+1))
    done
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

echo -n "record_list=" > ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
sed -i 's/\"RR\":/host_record=/g' ${temp_domain_file}
sed -i 's/\"Type\":/type=/g'  ${temp_domain_file}
sed -i 's/\"Value\":/value=/g'  ${temp_domain_file}
sed -i 's/\"Line\":/routing=/g'  ${temp_domain_file}
sed -i 's/\"TTL\":/ttl=/g'  ${temp_domain_file}
sed -i '/host_record/a\\    priority    = 0'  ${temp_domain_file}
sed -i '/\[\]/d'  ${temp_domain_file}
cat  ${temp_domain_file} | grep -v '^    \"' >> ${VARIABLES_PATH}/dns/${domain_replace}.tfvars
