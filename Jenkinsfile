pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    stat: agent
spec:
  containers:
  - name: make-build
    image: bryandollery/terraform-packer-aws-alpine
     command:
     - bash
     tty: true
     volumeMounts:
     - mountPath: /token
       name: k3s-sock
     volumes:
     - name: k3s-sock
        hostPath:
         path: k3s-packer
         name: host
"""
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
          stage ('make') {

            steps {
                //sh "make init"
              container ("make") {
                sh "make"
              }
            }
        }
          stage ('build') {

            steps {
                //sh "make init"
              container ("make-build") {
                sh "make build"
              }
            }
        }
    }
}