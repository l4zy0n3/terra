pipeline {
    agent any
    stages {
        stage('Set Terraform path') {
            steps {
                script {
                    def tfHome = tool name: 'Terraform'
                    env.PATH = "${tfHome}:${env.PATH}"
                }
                sh 'terraform --version'
            }
        }
        stage('Create Infra') {
            steps {
                withCredentials([file(credentialsId: 'yt_private_key', variable: 'yt_private_key'), file(credentialsId: 'yt_public_key', variable: 'yt_public_key'), string(credentialsId: 'DO_PAT', variable: 'do_token'), string(credentialsId: 'yt_ssh', variable: 'ssh_fingerprint')]) {
			sh """
                    		terraform init
                    		terraform plan \
                         		-var "do_token=${do_token}" \
                          		-var "pub_key=${yt_public_key}" \
                          		-var "pvt_key=${yt_private_key}" \
                          		-var "ssh_fingerprint=${ssh_fingerprint}"
				echo "Create : ${create}"
				echo "Destroy : ${destroy}"
                    	"""	
			script {
				if (create) {
                        		stage ('Create') {
                            			sh """
							terraform apply \
                          					-auto-approve \
			  					-var "do_token=${do_token}" \
                          					-var "pub_key=${yt_public_key}" \
                          					-var "pvt_key=${yt_private_key}" \
                          					-var "ssh_fingerprint=${ssh_fingerprint}"
						"""
                        		}
                    		}
                	}
			script {
				if (destroy) {
                        		stage ('Destroy') {
                            			sh """
							terraform destroy \
								-auto-approve \
                          					-var "do_token=${do_token}" \
                          					-var "pub_key=${yt_public_key}" \
                          					-var "pvt_key=${yt_private_key}" \
                          					-var "ssh_fingerprint=${ssh_fingerprint}"
						"""
                        		}
                    		}
                	}
		}
            }
        }
    }
}
