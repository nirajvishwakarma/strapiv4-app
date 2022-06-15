aws_region = "ap-south-1"

env1  = "test"
env2  = "dev"
env3  = "demo"
env4  = "prod"
env5  = "beta"

### EKS node group keys #####
ec2-key-test         = "wim-test-ssh"
ec2-key-dev          = "wim-dev-ssh"
ec2-key-demo         = "wim-demo-ssh"
ec2-key-prod         = "wim-prod-ssh"

#vpc1 (dev)
cidr-block1 = "192.168.0.0/16"
private-1-cidr = "192.168.0.0/18"
private-1-az = "ap-south-1a"
private-2-cidr = "192.168.64.0/18"
private-2-az = "ap-south-1b"

#public-nat
public-cidr = "192.168.128.0/18"
public-cidr2 = "192.168.192.0/18"
public-az = "ap-south-1a"
public2-az = "ap-south-1b"

#vpc1 (prod)
cidr-block3 = "192.170.0.0/16"
private-3-cidr = "192.170.0.0/18"
private-3-az = "ap-south-1a"
private-4-cidr = "192.170.64.0/18"
private-4-az = "ap-south-1b"

#public-nat
public-3-cidr = "192.170.128.0/18"
public-4-cidr = "192.170.192.0/18"
public-3-az = "ap-south-1a"
public-4-az = "ap-south-1b"


#vpc2 (Jenkins)
cidr-block2 = "10.0.1.0/24"
jenkins-public = "10.0.1.0/28"
jenkins-public-az = "ap-south-1a"


##EC2
ec2_instance_type = "t2.medium"
ec2-key           = "wim-jenkins-server"
#ports             = [0] 
ports             = [22, 80, 443,8080] 

## EKS
eks_version         = "1.22"