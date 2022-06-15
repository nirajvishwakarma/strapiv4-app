### EKS ####
output "cluster_name1" {
  value = aws_eks_cluster.aws_eks_test.name
}

output "eks_cluster_endpoint1" {
  value = aws_eks_cluster.aws_eks_test.endpoint
}

output "eks_cluster_certificate_authority1" {
  value = aws_eks_cluster.aws_eks_test.certificate_authority 
}

output "cluster_name2" {
  value = aws_eks_cluster.aws_eks_prod.name
}

output "eks_cluster_endpoint2" {
  value = aws_eks_cluster.aws_eks_prod.endpoint
}

output "eks_cluster_certificate_authority2" {
  value = aws_eks_cluster.aws_eks_prod.certificate_authority 
}

### VPC ###

output "VPC_1_id" {
  value = aws_vpc.WIM-dev.id
}

output "VPC_2_id" {
  value = aws_vpc.WIM-prod.id
}

output "VPC_3_id" {
  value = aws_vpc.jenkins.id
}

#### EC2 ####

output "ip" {
  value = "${aws_instance.jenkins-server.*.public_ip}"
}


