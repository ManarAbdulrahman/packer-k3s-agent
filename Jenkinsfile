 pipeline {
  agent {
    docker {
      image "bryandollery/terraform-packer-aws-alpine"
      args "-u root --entrypoint=''"
    }
  }
  environment {
    CREDS = credentials('phi-level2-project')
    AWS_ACCESS_KEY_ID= "${CREDS_USR}"
    AWS_SECRET_ACCESS_KEY= "${CREDS_PSW}"
    OWNER = 'Phi'
    PROJECT_NAME = 'phi-k3s-agent'
  }
  stages {
    stage("build") {
      steps {
        sh 'make && make build'
      }
    }
  }
}