pipeline {
  agent any

  stages {
    stage('Environment Setup') {
      steps {
        echo 'Starting application in CI environment...'

        // Up the system from scratch
        sh 'docker compose up -d --build'

        // Let's wait 5 seconds for the db and the app to be fully ready.
        sh 'sleep 5'
      }
    }

    stage('Run Tests') {
      steps {
        echo 'Running integration tests...'

        // Execute the curl command into the app and check the result.
        // If it returns status: success, the test will be considered successful.
        sh 'curl -s http://localhost:8000/ | grep "success"'
      }
    }
  }

  post {
    always {
      echo "Cleaning up the environment..."
      sh 'docker compose down'
    }
  }
}