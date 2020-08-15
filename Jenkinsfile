pipeline {
    agent any
    stages {
        stage('Set Terraform path') {
            steps {
                script {
                    def tfHome = tool name: 'Terraform'
                    env.PATH = "${tfHome}:${env.PATH}"
                }
                sh 'terraform — version'
            }
        }
        stage('Create Infra') {
            steps {
                sh """
                    export TF_LOG=1
                    terraform plan
                    terraform ally
                """
            }
        }
    }
}
