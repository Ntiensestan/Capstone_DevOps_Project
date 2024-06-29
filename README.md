# Capstone_DevOps_Project Documentation.

 These project provides practical learning experiences and cover various aspects of DevOps.

## This is the Main Project Repository >>>>[Capstone_DevOps](https://github.com/Ntiensestan/Capstone_DevOps.git)

# 1.Containerizing Applications with Docker

This helps to create, manage, and deploy Docker containers for consistent and efficient application environments.

### Step 1: Installing Docker with the neccessary dependencies on local machine >>>>[Docker Installation](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

### Step 2
    -On the terminal, create a directory. 
    -Cd into the directory and create two files namely; dockerfile and index.html.
    -In the index.html, write "Hello World"
    -Write the Dockerfile.

Dockerfile code

```php
# Using a PHP runtime as a parent image
FROM php:7.2-apache

# Setting working directory in the container
WORKDIR /var/www/html

# Copinging PHP application code into the container
COPY . .

#Installing PHP extensions and Dependencies
RUN apt-get update && \
    apt-get install -y libpng-dev && \
    docker-php-ext-install pdo pdo_mysql gd

# Exposed port
EXPOSE 80

# Start Apache when the container runs
CMD ["apache2-foreground"]

```


### Step 3: Build the docker imgage
> docker build -t project_1

### Step 4: Run and manage the container
- With the built image, a container is created from it.
- The following command is use to start a container with the exposed port.
> docker run -d -p8080:80 project_1
- The -d flag runs the container in detached mode (that is, running in the background).
- Post the exposed port in http://localhost to view in web browser.

### Step 5: Push the docker image to docker Hub
- On the docker Hub account, create a new reopsitory
- Login to docker Hub on the commad line 
> docker login -u username
> password:
- Tag the Image
> docker tag image-name dockerhub-username/repository-name:version

# 2. Infrastructure as Code with Terraform
Terraform provides a flexible solution for managing infrastructure.  This project once it is provisioned, it will automatically install Docker and every server that is spun up automatically has Docker installed. It should also pull and Run the specified docker Image.


### Step 1: Installing Terraform on local machine >>>>[Terraform Installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Step 2: Setting up AWS on your terminal
- Ensure to have an AWS account
- Configure AWS credentials on your terminal using
> aws configure
- Input the AWS secret access key, access key ID, region and default output format (jason).
- ssh keys (both private and public) are generated and saved in the ssh file on the machine.

### Step 3: Create a Terraform Configuration file
- Create a new directory for the project.
- Inside the directory, create a main.tf file where the terraform configuration code is written, where the required providers and resources are stated.

### Step 4: Create a shell Script
 A userdata/shell Script (.sh file) is created  that will automatically install Docker once the application is provisioned and will also pull and run the docker image.


### Step 5: The following commands are run
> terraform init
terraform plan
terraform apply
 
### Step 6: Check AWS account to confirm if the instance is running.


# 3. Automated Deployment Pipeline with GitHub Actions.

This project will automate our infrastructure deployment to AWS.

*For this project,the terraform code and the .sh file in project 2 is used.*

### Step 1: To Create a new repository on Github
- Login to github account
- Click on new repository
- Name the repository
- Make it public
- Click on create repository.
- Add the Aws secret keys(access key ID and secret access key)

### Step 2: To create a Github actions workflow file (.github/workflows/terraform-pipeline.yml)

- Create .github directory
- Cd into the .github directory and create another directory named workflows.
- Cd into the workflows and create a file called terraform -pipeline.yml.

### Step 3: Configuring the workflow

- Trigger workflows with varieties of events such as push and pull.
- Configure environments to set rules before a job can proceed, inputing the AWS access key ID and secret access key.
- The following steps were added to the workflow; checkout, setup terraform, terraform init, validate, plan and apply.


### Step 4: Create a pull and push request to send the files to github repostory 

### step 5: Check the repository on github if the pipeline workflow was executed successfully.

If it is successfull, a new instance should be running in AWS and docker automatically installed in the server.

# 4. Ansible Task to Deploy Nginx.

 This project is using Ansible to deploy the Nginx web server to another Ubuntu server.

### Step 1. Installing Ansible >>>>[Ansible Installation](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-20-04)

### Step 2. Login to AWS console
- Navigate to Ec2 dashboard
- Click on launch instance
- Choose the neccessary parameters for the instance.
- Select t2.micro for the instance type.
- Create a key-pair with a .pem extension and change the permissions using chmod 400 name of key.pem
- Launch the instance.
- Go to instances
- Click on the running instance and connect to the server.

### Step 3. Create a directory on your terminal.
- Create a an inventory.ini file where the groups and hosts are defined.
- On the terminal, ping the host defined in the inventory.ini file using the command below;
> ansible all -i inventory.ini -m ping
- If successfull, a "ping":"pong" response will be displayed.

### Step 4. Create a file called Playbook.yml in the ansible directory.

The playbook.yml play
```yml
---

- name: Nginx Server
  hosts: all
  become: yes
  become_user: root

  tasks:
    - name: Update Instances
      apt:
        name: "*"
        state: latest
        update_cache: yes

    - name: install nginx server
      apt:
        name: nginx
        state: latest
    - name: start nginx server
      ansible.builtin.service:

```
- The playbook executed using the following command;
> ansible-playbook -i inventory.ini playbook.yaml

- Outputs indicating the successes of each task should be displayed.
- The nginx can be viewed on a browser.# Capstone_DevOps_Project
