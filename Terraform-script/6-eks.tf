#SUMMARY

#  1. IAM Role for EKS Cluster
#  2. IAM Role for EKS Nodes
#  3. Create EKS Cluster
#  4. Create EKS Node Groups

############## TEST ################

#IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_test" {
  name = "WIM-eks-cluster-${var.env1}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
 "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy_test" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_test.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy_test" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_test.name
}

##Create EKS Cluster
resource "aws_eks_cluster" "aws_eks_test" {
  name     = "WIM-${var.env1}"
  role_arn = aws_iam_role.eks_cluster_test.arn
  version  = "${var.eks_version}"

  vpc_config {
    subnet_ids = [aws_subnet.public.id, aws_subnet.public2.id]
  }

  tags = {
    Name = "WIM-${var.env1}" 
  }
}

#IAM Role for EKS Nodes
resource "aws_iam_role" "eks_nodes_test" {
  name = "WIM-eks-node-group-${var.env1}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy_test" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes_test.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy_test" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes_test.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly_test" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes_test.name
}

##Create EKS Node Groups
resource "aws_eks_node_group" "eks_node_test" {
  cluster_name    = aws_eks_cluster.aws_eks_test.name
  node_group_name = "WIM-${var.env1}-nodes"
  node_role_arn   = aws_iam_role.eks_nodes_test.arn
  subnet_ids      = [aws_subnet.public.id, aws_subnet.public2.id]
  instance_types = ["t2.medium"]

  remote_access {
    ec2_ssh_key = "${var.ec2-key-test}"
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy_test,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy_test,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly_test,
  ]
}


############## DEV ################

#IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_dev" {
  name = "WIM-eks-cluster-${var.env2}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
 "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy_dev" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_dev.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy_dev" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_dev.name
}

##Create EKS Cluster
resource "aws_eks_cluster" "aws_eks_dev" {
  name     = "WIM-${var.env2}"
  role_arn = aws_iam_role.eks_cluster_dev.arn
  version  = "${var.eks_version}"

  vpc_config {
    subnet_ids = [aws_subnet.public.id, aws_subnet.public2.id]
  }

  tags = {
    Name = "WIM-${var.env2}" 
  }
}

#IAM Role for EKS Nodes
resource "aws_iam_role" "eks_nodes_dev" {
  name = "WIM-eks-node-group-${var.env2}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy_dev" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes_dev.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy_dev" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes_dev.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly_dev" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes_dev.name
}

##Create EKS Node Groups
resource "aws_eks_node_group" "eks_node_dev" {
  cluster_name    = aws_eks_cluster.aws_eks_dev.name
  node_group_name = "WIM-${var.env2}-nodes"
  node_role_arn   = aws_iam_role.eks_nodes_dev.arn
  subnet_ids      = [aws_subnet.public.id, aws_subnet.public2.id]
  instance_types = ["t2.medium"]

  remote_access {
    ec2_ssh_key = "${var.ec2-key-dev}"
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy_dev,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy_dev,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly_dev,
  ]
}


################ DEMO ################

#IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_demo" {
  name = "eks-cluster-${var.env3}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
 "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy_demo" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_demo.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy_demo" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_demo.name
}


##Create EKS Cluster
resource "aws_eks_cluster" "aws_eks_demo" {
  name     = "WIM-${var.env3}"
  role_arn = aws_iam_role.eks_cluster_demo.arn
  version  = "${var.eks_version}"

  vpc_config {
    subnet_ids = [aws_subnet.public-3.id, aws_subnet.public-4.id]
  }

  tags = {
    Name = "WIM-${var.env3}" 
  }
}

##IAM Role for EKS Nodes
resource "aws_iam_role" "eks_nodes_demo" {
  name = "eks-node-group-${var.env3}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy_demo" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes_demo.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy_demo" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes_demo.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly_demo" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes_demo.name
}


##Create EKS Node Groups
resource "aws_eks_node_group" "node_demo" {
  cluster_name    = aws_eks_cluster.aws_eks_demo.name
  node_group_name = "WIM-${var.env3}-nodes"
  node_role_arn   = aws_iam_role.eks_nodes_demo.arn
  subnet_ids      = [aws_subnet.public-3.id, aws_subnet.public-4.id]
  instance_types = ["t2.medium"]

  remote_access {
    ec2_ssh_key = "${var.ec2-key-demo}"
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy_demo,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy_demo,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly_demo,
  ]
}


################ PROD ################

#IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_prod" {
  name = "eks-cluster-${var.env4}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
 "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy_prod" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_prod.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy_prod" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_prod.name
}


##Create EKS Cluster
resource "aws_eks_cluster" "aws_eks_prod" {
  name     = "WIM-${var.env4}"
  role_arn = aws_iam_role.eks_cluster_prod.arn
  version  = "${var.eks_version}"

  vpc_config {
    subnet_ids = [aws_subnet.public-3.id, aws_subnet.public-4.id]
  }

  tags = {
    Name = "WIM-${var.env4}" 
  }
}

##IAM Role for EKS Nodes
resource "aws_iam_role" "eks_nodes_prod" {
  name = "eks-node-group-${var.env4}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy_prod" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes_prod.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy_prod" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes_prod.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly_prod" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes_prod.name
}


##Create EKS Node Groups
resource "aws_eks_node_group" "node_prod" {
  cluster_name    = aws_eks_cluster.aws_eks_prod.name
  node_group_name = "WIM-${var.env4}-nodes"
  node_role_arn   = aws_iam_role.eks_nodes_prod.arn
  subnet_ids      = [aws_subnet.public-3.id, aws_subnet.public-4.id]
  instance_types = ["t2.medium"]

  remote_access {
    ec2_ssh_key = "${var.ec2-key-prod}"
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy_prod,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy_prod,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly_prod,
  ]
}
