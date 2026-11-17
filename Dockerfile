FROM nginx:alpine
COPY jenkins.html /usr/share/nginx/html/index.html
COPY jenkins.css /usr/share/nginx/html/jenkins.css
EXPOSE 80
