pipeline {
  agent any
  options { timestamps() }

  environment {
    IMAGE = 'monapp'
    TAG   = "build-${env.BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }   // lit le meme repo que le job
    }

    stage('Docker Build') {
      steps {
        bat 'docker version'
        bat "docker build -t %IMAGE%:%TAG% ."
      }
    }

    stage('Smoke Test') {
      steps {
        bat """
          docker rm -f monapp_test 2>nul || ver > nul
          docker run -d --name monapp_test -p 8081:80 %IMAGE%:%TAG%
          ping -n 3 127.0.0.1 > nul
          curl -I http://localhost:8081 | find "200 OK"
          docker rm -f monapp_test
        """
      }
    }

    stage('Push (Docker Hub)') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                          usernameVariable: 'USER',
                                          passwordVariable: 'PASS')]) {
          bat """
            echo %PASS%| docker login -u %USER% --password-stdin
            docker tag %IMAGE%:%TAG% %USER%/%IMAGE%:%TAG%
            docker tag %IMAGE%:%TAG% %USER%/%IMAGE%:latest
            docker push %USER%/%IMAGE%:%TAG%
            docker push %USER%/%IMAGE%:latest
          """
        }
      }
    }

    stage('Deploy (Staging)') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                          usernameVariable: 'DOCKERHUB_USER',
                                          passwordVariable: 'DH_PASS')]) {
          bat 'docker compose pull'
          bat 'docker compose up -d'
          bat 'docker ps'
        }
      }
    }
  }

  post {
    success { echo 'Build+Test+Push+Deploy OK - http://localhost:8082' }
    failure { echo 'Build/Tests/Push KO' }
  }
}
