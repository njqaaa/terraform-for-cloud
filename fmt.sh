# 配置文件格式化
find . -name \*.tf |while read line;do terraform fmt ${line};done
