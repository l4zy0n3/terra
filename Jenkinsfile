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
                sh """
                    export TF_LOG="DEBUG"
                    terraform init
                    terraform plan \
                          -var "do_token=${do_token}" \
                          -var "pub_key=${yt_public_key}" \
                          -var "pvt_key=${yt_private_key}" \
                          -var "ssh_fingerprint=${ssh_fingerprint}"
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
}
