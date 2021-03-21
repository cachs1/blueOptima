# blueOptima
aws/terraform/ansible

Deploy an ec2 instance, configure terraform and ansible to work with your aws infrastructure

## [Prerequisites]
- Have your ec2 Bastion host (amazon-linux2) instance
- pem key to access your servers
- Add tags to your servers you would like to save logs depending on OS (ex. Key:Ubuntu Value:Server, Key:Centos Value:Server)

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
  
## [Setting up the environment AWS CLI]

1. Depending on the OS, install pythons pip (Pythons package installer)

  `$ sudo yum -y install python3-pip`
  
2. Use pip to install AWS CLI and Ansible

  `$ pip3 install awscli --user`
  
3. Download Ansible
`
  $ sudo amazon-linux-extras install ansible2
`
4. Check if its all isntalled

  `$ ansible --version`
  
5. Configure AWS CLI add your credentials
```
  $ aws configure
  $ default region name: us-east-1
  $ default output format: json
```  
6. Check if our aws configuration was right

 `$ aws ec2 describe-instances`
 
## [Setting up pip]

1. Install package necesary for dynamic inventory
```
  $ sudo yum install python-pip
  $ pip install boto3 --user
````  
## [Setting up the Environment]

1. Copy this policy and paste it into AWS Console IAM Policy, it is necesary for the playbook to run

  `https://raw.githubusercontent.com/cachs1/blueOptima/master/policy/terraform_ansible_iam_policy.json`
   
2. Add User - Add Programamtic Access - Attach new created policy 

3. Save Access Key ID and Secret Key (FOR TERRAFORM AND ANSIBLE)

## [Setting up Terraform]

1. Copy all terraform files on a directory

  `$ mkdir terraform`
  
2. Edit name on s3.tf name of bucket creation
```
  variable "s3-name" {
  type    = string
  default = YOUR BUCKET NAME 
 }
```

2. After copy all, lets run Terraform init
```
  $ terraform init
  $ terraform fmt
  $ terraform apply
```  
## [Setting up Ansible]

1. Copy all ansible files on a directory
```
  $ mkdir ansible_templates
  $ cd ansible_templates
  $ curl -O https://raw.github.com/cachs1/blueOptima/blob/master/ansible_templates/amzn2.yml
  $ curl -O https://raw.github.com/cachs1/blueOptima/blob/master/ansible_templates/centos.yml
  $ curl -O https://raw.github.com/cachs1/blueOptima/blob/master/ansible_templates/ubuntu.yml
```  
2. Edit Vars and Bucket name on the files corresponding to your bucket name creation
```
   vars:
    access_key: #YOUR ACCESS KEY
    secret_key: #YOUR SECRET KEY
   bucket: #YOUR BUCKET NAME
```
2. Create another directory for the inventory plug in
```
  $ mkdir inventory
  $ cd inventory
  $ curl -O https://raw.githubusercontent.com/cachs1/blueOptima/master/ansible_templates/inventory/aws_ec2.yml
```  
3. Edit aws_ec2.yml file and add the keys from the policy 
```
  aws_access_key: <PUT IN YOUR AWS ACCESS KEY>
  aws_secret_key: <PUT IN YOUR AWS SECRET KEY>
```
5. SCP your pem key if its a new server, where -i is your key, file, user@ip bastion host : home of server

  `scp -i test.pem test.pem ec2-user@x.x.x.x:~/.`

6. Edit your ansible.cfg file from etc to put the respective files
```
  inventory = # YOUR ROUTE FOR INVENTORY aws_ec2.yml
  enable_plugins = aws_ec2
  interpreter_python = auto_silent
  private_key_file = # YOUR PRIVATE PEM KEY ROUTE
```  
## [Test playbooks]

1. Move to ansible_templates

 ` $ ansible-playbook -e "passed_in_hosts=tag_Ubuntu_Server" ubuntu.yml`
  
You should be able to see a successfull playbook installing all requeriments to upload to s3 bucket

  
## [Adding a crontab for running everyweek]

1. Edit crontab for automatic playbooks even if you add new server
```
  $ crontab -e
  0 0 * * 0 ansible-playbook "passed_in_hosts=tag_Ubuntu_Server" /home/ec2-user/terraform/ansible_templates/ubuntu.yml
```

## [Expand further]

1. Make roles and save credentials on Ansible vault
1. Create and run you playbooks while running terraform, creating a new infrastructure using "local-exec"
2. Use SNS to push messages after playbook
  




