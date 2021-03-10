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
  $ sudo yum-config-manager -enable epel
  $ sudo yum update
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

   $ wget
   
2. Add User - Add Programamtic Access - Attach new created policy 

3. Save Access Key ID and Secret Key





