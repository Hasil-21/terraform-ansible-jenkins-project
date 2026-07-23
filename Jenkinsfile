pipeline {
	agent any

	environment{
		AWS_DEFAULT_REGION = 'ap-south-1'
		TF_DIR = 'terraform'
		ANSIBLE_DIR = 'ansible'
	}

	stages{
		stage('Checkout'){
			steps{
				checkout scm
			}
		}

		stage('Terraform init'){
			steps{
				dir("${TF_DIR}"){
					sh 'terraform init'
				}
			}
		}

		stage('Terraform Plan'){
			steps{
				dir("${TF_DIR}"){
					sh 'terraform plan -out=tfplan'
				}
			}
		}

		stage('Approve Apply'){
			steps{
				input message: 'Approve this terraform plan?'
			}
		}

		stage('Terraform Apply'){
			steps{
				dir("${TF_DIR}"){
					sh 'terraform apply -auto-approve tfplan'
				}
			}
		}

		stage('Run Ansible - App'){
			steps{
				dir("${ANSIBLE_DIR}"){
					sh 'ansible-playbook -i inventory_generated.ini site.yml --limit app'
				}
			}
		}

		stage('Smoke Test'){
			steps{
				dir("${TF_DIR}"){
					sh '''
						ALB_DNS=$(terraform output -raw alb_dns_name)
						echo "waiting for target to become healthy..."
						sleep 30
						curl -sf http://$ALB_DNS || exit 1
						echo "App is reachable at http://$ALB_DNS"
					'''
				}
			}
		}
	}

	post{
		success{
			echo 'pipeline completed successfully.'
		}
		failure{
			echo 'pipeline failed - check the stage logs.'
		}
	}
}

