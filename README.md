# blueOptima
aws/terraform/ansible

## [Prerequisites]
- Have your ec2 instance in your vpc where you can see all server (ec2)
- pem key to access your servers

## [Terraform]

1. Download terraform binary

 `$ wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip`

2. Unzip terraform
```
 $ sudo yum -y install unzip
 $ unzip terraform_0.14.7_linux_amd64.zip
```

3. echo $PATH to check all routes

  `$ echo $PATH`
  
4. Move Terraform unziped file to usr/local/bin

  `$ sudo mv terraform /usr/local/bin`
  
5. Check if terraform is available from anywhere

  `$ terraform version`
  
## [Setting up the environment AWS CLI and Ansible]

1. Depending on the OS, install pythons pip (Pythons package installer)

  `$ sudo yum -y install python3-pip`
  
2. Use pip to install AWS CLI and Ansible

  `$ pip3 install awscli --user`
  
3. Download Ansible
```
  $ sudo amazon-linux-extras install ansible2
```
4. Check if its all isntalled

  `$ ansible --version`
  
5. Configure AWS CLI
```
  $ aws configure
  $ default region name: us-east-1
  $ default output format: json
```  
6. Check if our aws configuration was right

 `$ aws ec2 describe-instances`
  
  
## [Setting up the Environment]

1. Copy this policy into AWS Console

  $ wget https://raw.githubusercontent.com/cachs1/blueOptima/master/policy/terraform_ansible_iam_policy.json
   
2. Add User - Add Programamtic Access - Attach new created policy 

3. Save Access Key ID and Secret Key (FOR TERRAFORM AND ANSIBLE)

## [Setting up Terraform]

1. Copy all terraform files on a directory

  $ mkdir terraform
  
2. Edit name on s3.tf name of bucket creation

  variable "s3-name" {
  type    = string
  default = "NAME OF YOUR BUCKET"
  }


2. After copy all, lets run Terraform init

  $ terraform init
  $ terraform fmt
  $ terraform apply
  
## [Setting up Ansible]

1. Copy all ansible files on a directory

  $ mkdir ansible_templates
  $ cd ansible_templates
  $ curl -O https://raw.github.com/cachs1/blueOptima/blob/master/ansible_templates/amzn2.yml
  $ curl -O https://raw.github.com/cachs1/blueOptima/blob/master/ansible_templates/centos.yml
  $ curl -O https://raw.github.com/cachs1/blueOptima/blob/master/ansible_templates/ubuntu.yml
  
2. Edit Vars and Bucket name on the files corresponding to your bucket name creation

   vars:
    access_key: #YOUR ACCESS KEY
    secret_key: #YOUR SECRET KEY
  bucket: #YOUR BUCKET NAME

2. Create another directory for the inventory plug in

  $ mkdir inventory
  $ cd inventory
  $ curl -O https://raw.githubusercontent.com/cachs1/blueOptima/master/ansible_templates/inventory/aws_ec2.yml
  
3. Edit aws_ec2.yml file and add the keys from the policy 

  aws_access_key: <PUT IN YOUR AWS ACCESS KEY>
  aws_secret_key: <PUT IN YOUR AWS SECRET KEY>


  




