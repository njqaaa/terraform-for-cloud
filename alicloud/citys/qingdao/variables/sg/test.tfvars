group_name="test"
rule_directions=["ingress", "ingress", "ingress"]
ip_protocols=["tcp", "tcp", "icmp"]
policies=["accept", "accept", "accept"]
port_ranges=["80/119", "22/29", "-1/-1"]
priorities=[1, 2, 3]
cidr_ips=["192.168.3.2/32", "0.0.0.0/0",  "10.0.0.3/32"]
