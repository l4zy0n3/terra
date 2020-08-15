pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                sh """
                    export PATH=$PATH:~/opt/terraform/bin
                    export TF_LOG=1
                    terraform plan
                    terraform ally
                """
            }
        }
    }
}
