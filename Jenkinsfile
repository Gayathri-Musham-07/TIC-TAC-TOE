pipeline {
    agent { label 'deploy' }

    environment {
        AWS_ACCOUNT_ID = '043309327282'
        AWS_REGION = 'ap-south-1'
        EC2_USER = 'ubuntu'
        EC2_HOST = '43.204.211.223'
        APP_DIR = '/home/ubuntu/tic-tac-toe'
    }

    stages {
        stage('Clone Repository') {
            steps {
                withCredentials([string(credentialsId: 'git-hub-token', variable: 'GITHUB_TOKEN')]) {
                    sh '''
                    echo "Cloning repository..."
                    rm -rf TIC-TAC-TOE  # Remove old files if they exist
                    git clone https://github.com/Gayathri-Musham-07/TIC-TAC-TOE.git

                    '''
                }
            }
        }

        stage('Run Linter') {
            steps {
                sh '''
                chmod +x run-linter.sh
                ./run-linter.sh
                '''
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['d2eabc6a-7ba1-47aa-baa4-5cb2c13fb442']) {
                    sh '''
                    echo "Transferring application files to EC2..."
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST "mkdir -p $APP_DIR"
                    scp -o StrictHostKeyChecking=no -r TIC-TAC-TOE/* $EC2_USER@$EC2_HOST:$APP_DIR/

                    echo "Deploying application..."
                    ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << EOF
                    cd $APP_DIR

                    # Kill existing Python server if running
                    echo "Stopping existing Python server (if any)..."
                    pkill -f "python3 -m http.server 8000" || true

                    echo "Starting new Python web server..."
                    nohup python3 -m http.server 8000 > server.log 2>&1 &

                    echo "Deployment Complete! Access at http://$EC2_HOST:8000"
                    EOF
                    '''
                }
            }
        }
    }
}
