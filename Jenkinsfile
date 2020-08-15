pipeline {
    agent any

    stages {
        stage('Hello') {
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
