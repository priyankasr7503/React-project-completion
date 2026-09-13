pipeline {
  agent any
  options { timestamps(); disableConcurrentBuilds() }
  environment {
    DEV_IMAGE = 'priyarchandra/dev-app'
    PROD_IMAGE = 'priyarchandra/prod-app'
  }
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Select image') {
      steps { script {
        env.TARGET_IMAGE = (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') ? env.PROD_IMAGE : env.DEV_IMAGE
        env.IMAGE_TAG = env.BUILD_NUMBER
      } }
    }
    stage('Build') { steps { sh 'docker build --pull -t $TARGET_IMAGE:$IMAGE_TAG -t $TARGET_IMAGE:latest .' } }
    stage('Verify') {
      steps { sh '''docker rm -f app-test >/dev/null 2>&1 || true
        docker run -d --name app-test -p 8081:80 $TARGET_IMAGE:$IMAGE_TAG
        for i in 1 2 3 4 5; do wget -q --spider http://localhost:8081 && exit 0; sleep 2; done
        docker logs app-test
        exit 1''' }
      post { always { sh 'docker rm -f app-test >/dev/null 2>&1 || true' } }
    }
    stage('Push') {
      steps { withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_TOKEN')]) {
        sh '''echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USER" --password-stdin
        docker push $TARGET_IMAGE:$IMAGE_TAG
        docker push $TARGET_IMAGE:latest
        docker logout'''
      } }
    }
    stage('Deploy') {
      when { anyOf { branch 'dev'; branch 'main'; branch 'master' } }
      steps { sh 'chmod +x deploy.sh && APP_IMAGE=$TARGET_IMAGE:$IMAGE_TAG ./deploy.sh' }
    }
    stage('Health check') { steps { sh 'wget -q --spider http://localhost:80/' } }
  }
}
