rule_directions=["ingress", "ingress", "ingress"]
ip_protocols=["tcp", "tcp", "icmp"]
policies=["accept", "accept", "accept"]
port_ranges=["80/80", "22/22", "-1/-1"]
priorities=[1, 1, 1]
cidr_ips=["0.0.0.0/0", "0.0.0.0/0",  "10.0.0.3/32"]
