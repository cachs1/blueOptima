# blueOptima
aws/terraform/ansible

Deploy an ec2 instance, configure terraform and ansible to work with your aws infrastructure

## [Prerequisites]
- Have your ec2 Bastion host (amazon-linux2) instance
- pem key to access your servers

## [Terraform]

1. Connect to your ec2 instance and download terraform binary

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
6. Check if our aws configuration was right, it should output information

 `$ aws ec2 describe-instances`
 
## [Setting up pip]

1. Install package necesary for dynamic inventory
```
  $ sudo yum install python-pip
  $ pip install boto3 --user
````  
## [Setting up the Environment]

1. Open up AWS Console and copy this policy and paste it into AWS Console IAM Policy, it is necesary for the playbook to run

  `https://raw.githubusercontent.com/cachs1/blueOptima/master/policy/terraform_ansible_iam_policy.json`
   
2. Add User - Add Programamtic Access - Attach new created policy 

3. Save Access Key ID and Secret Key (FOR TERRAFORM AND ANSIBLE)

## [Clone Repo]

1. Clone repository inside you home, and move to it
```
  $ git clone https://github.com/cachs1/blueOptima.git
  $ cd blueOptima
```

2. Here you will have the nex files
```
 ansible.cfg
 other_questions
 policy
 README.md
 terraform
```
## [Setting up Terraform]

1. Move to terraform directory so we can edit all files to our use case

  `cd terraform`
  
3. Edit name on variables.tf name of bucket creation
```
  variable "region-master" {
   type    = string
   default = "YOUR REGION AWS"
 }

  variable "s3-name" {
   type    = string
   default = "YOUR BUCKET NAME" 
 }
```

2. After copy all, lets run Terraform init
```
  $ terraform init
  $ terraform fmt
  $ terraform apply
```  
## [Setting up Ansible]

1. Move into ansible_templates

  `cd ansible_templates`


2. Edit variables file named "keys.yml" and "windows_keys.yml" with your use case scenario corresponding the values
```
#AWS CONF
access_key: <ADD_HERE_YOUR_ACCESS_KEY>
secret_key: <ADD_HERE_YOUR_SECRET_KEY>

#S3 BUCKET CONF
region: <ADD_HERE_REGION>
bucket_name: <ADD_HERE_BUCKET_NAME>

#MAIL CONF
username_mail: <ADD_HERE_YOUR_USERNAME>
password_mail: <ADD_HERE_YOUR_PASSWORD>
to_mail: <ADD_HERE_WHO_SEND_MAIL@gmail.com>

#DAYS YOU WANT YOUR BACKUP FOR N DAYS, EXAMPLE 
#n_days: -1d      #MODIFIED PAST DAY
#n_days: 5d       #MODIFIED PAST 5 DAYS
n_days: <DAYS FOR BACKUP>


```

2. Edit inventory file with your corresponding values
```
  $ vim inventory/aws_ec2.yml
 
 #set aws_access_key and secret_key.
aws_access_key: <PUT IN YOUR AWS ACCESS KEY>
aws_secret_key: <PUT IN YOUR AWS SECRET KEY>



#set region
regions: 
  - <PUT IN YOUR REGION>
# - us-east-2# set strict to False    
# if True this will make invalid entries 
# a fatal error
strict: False



```  
3. (optional). If you dont have your pem key on your bastion host you can SCP your pem key to the new server, where -i is your key(local), file(file to transfer), user@ip_bastion_host:home_of_new_server

  `scp -i test.pem test.pem ec2-user@x.x.x.x:~/.`

4. Copy the ansible.cfg file into your /etc/ansible/ansible.cfg file

  `$ cp ansible.cfg /etc/ansible/ansible.cfg`

5. Change variables for your case
```  
  inventory = #YOUR ROUTE FOR INVENTORY/aws_ec2.yml
  #inventory = /home/ec2-user/terraform/ansible_templates/inventory/aws_ec2.yml
  private_key_file = # YOUR PRIVATE PEM KEY ROUTE
  #private_key_file = /home/ec2-user/blueOptima.pem
```  
6. Encrypt sensitive files with ansible-vault
```  
 ansible-vault encrypt keys.yml
 ansible-vault encrypt 
```  



## [Test playbooks]

1. Test ansible playbooks moving to ansible_templates, the way it works is only you have to pass the user to connect to different OS for example if you would like to connect to centos you would pass user 'centos', for ubuntu it would be 'ubuntu', for amazon-ec2 it would be 'ec2-user'
```  
  $ ansible-playbook main.yml -u centos
  $ ansible-playbook main.yml -u ubuntu
  $ ansible-playbook main.yml -u ec2-user

```  
This is way an easy way to connect to different flavours of OS

  
## [Adding a crontab for running everyweek]

1. Edit crontab for automatic playbooks even if you add new server
```
  $ crontab -e
  0 0 * * 0 ansible-playbook /home/ec2-user/terraform/ansible_templates/main.yml -u ubuntu
  0 0 * * 0 ansible-playbook /home/ec2-user/terraform/ansible_templates/main.yml -u centos
  0 0 * * 0 ansible-playbook /home/ec2-user/terraform/ansible_templates/main.yml -u ec2-user
```

## [Expand further]

1. Any other OS added to your aws environment, you could just add a simple task to install python, pip, and name it on the block main.yml file so when ansible checks another OS it would run the task
2. Use Regex for s3 upload of files
3. Run Windows aws sdk for upload to s3 from within windows
4. Better format on roles

  




