#Execution Steps

#Your Machine

- terraform init/plan/apply to get infrastructure
- ansible-playbook -i inventory_generated.ini site.yml --limit jenkins to configure the jenkins-controller ec2
- create required associate policy document and attach it to jenkins-controller ec2

#Jenkins Controller EC2

- copy the key for this to access the app ec2 in its required location /var/lib/jenkins/<key-name>

#Configure Jenkins Pipeline

- go to jenkins website and create a new item of type pipeline
- add github repo link and git trigger

#Add Github Webhook

- go to you repo > settings > webhook > add webhook
- add your jenkinslink:8080/github-webhook/ and save

#Done
