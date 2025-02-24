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
        stage('Plan Infra') {
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
				stage ('Create') {
					if (env.create.toBoolean()) {
                            			sh """
							terraform apply \
                          					-auto-approve \
			  					-var "do_token=${do_token}" \
                          					-var "pub_key=${yt_public_key}" \
                          					-var "pvt_key=${yt_private_key}" \
                          					-var "ssh_fingerprint=${ssh_fingerprint}"
						"""
                        		}
					else {
						echo "Not Creating"
					}
                    		}
                	}
			script {
                        	stage ('Destroy') {
                            		if (env.destroy.toBoolean()) {
						sh """
							terraform destroy \
								-auto-approve \
                          					-var "do_token=${do_token}" \
                          					-var "pub_key=${yt_public_key}" \
                          					-var "pvt_key=${yt_private_key}" \
                          					-var "ssh_fingerprint=${ssh_fingerprint}" \
								-var "server_image=${server_image}" \
								-var "server_count=${server_count}" \
								-var "region=${"region"}" \
								-var "server_size=${server_size}"
						"""
                        		}
					else {
						echo "Not Destroying"
					}
                    		}
                	}
		}
            }
        }
    }
}
