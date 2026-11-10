pipeline {
    agent any

    options { timestamps() }

    stages {
        stage('Cloner le dépôt') {
            steps {
                // Jenkins recupere le depot configure dans le job (Pipeline script from SCM)
                checkout scm
            }
        }

        stage('Étape 1 : Vérification du dépôt') {
            steps {
                bat 'echo === Etape 1 : Verification du depot ==='
                bat 'git status'
            }
        }

        stage('Étape 2 : Afficher le contenu du projet') {
            steps {
                bat 'echo === Etape 2 : Afficher le contenu du projet ==='
                bat 'dir'
            }
        }

        stage('Étape 3 : Simuler un déploiement local') {
            steps {
                bat 'echo === Etape 3 : Simuler un deploiement local ==='
                bat 'if exist tp2.html (echo Le fichier tp2.html est pret a etre affiche) else (echo tp2.html introuvable & exit /b 1)'
            }
        }

        stage('Étape 4 : Fin du build') {
            steps {
                bat 'echo === Etape 4 : Fin du build ==='
                bat 'echo SUCCESS'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '*.html, *.css', allowEmptyArchive: true
        }
        success { echo 'Build OK' }
        failure { echo 'Build KO' }
    }
}
