#!/usr/bin/env python
#coding=utf-8

import os
from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.acs_exception.exceptions import ClientException
from aliyunsdkcore.acs_exception.exceptions import ServerException
from aliyunsdkecs.request.v20140526.DescribeSecurityGroupAttributeRequest import DescribeSecurityGroupAttributeRequest
import json
client = AcsClient(os.environ['ACCESS_KEY_ID'], os.environ['ACCESS_KEY_SECRET'], 'cn-zhangjiakou')

request = DescribeSecurityGroupAttributeRequest()
request.set_accept_format('json')

request.set_SecurityGroupId("sg-8vbih42mb4r8y8la6oll")

response = client.do_action_with_exception(request)
#response = client.do_action_with_exception(request)
#print(response)
xx = str(response, encoding='utf-8')
#print (xx)
yy=json.loads(xx).get('Permissions').get('Permission')
count = len(yy)
for i in range(4):
    print('%s:%s:%s:%s:%s:%s:%s' % ( yy[i]['Direction'], yy[i]['IpProtocol'], yy[i]['SourcePortRange'], yy[i]['NicType'] ,yy[i]['SourceCidrIp'], yy[i]['Policy'], yy[i]['Priority'] ))
#print(yy['SecurityGroupId'])
#print(yy['PortRange'])
# python2: print(response) 
#print(str(response, encoding='utf-8'))
