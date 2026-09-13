# eCommerce DevOps Deployment

## Submission links
- GitHub repository: `ADD_FINAL_GITHUB_URL`
- Deployed site: `http://ADD_EC2_PUBLIC_IP`
- Development image: `priyarchandra/dev-app:latest`
- Production image: `priyarchandra/prod-app:latest`

## Flow
GitHub webhook -> Jenkins multibranch pipeline -> Docker build and health test -> Docker Hub -> EC2 Docker Compose -> Prometheus/Blackbox Exporter -> Grafana.

## Deploy
```bash
chmod +x build.sh deploy.sh
./build.sh
GF_ADMIN_PASSWORD='use-a-strong-password' ./deploy.sh
```
Application: port 80. Prometheus: port 9090. Grafana: port 3000.

## Jenkins
Install Docker Pipeline, Git, GitHub Branch Source, and Pipeline plugins. Create a Username/Password credential named `dockerhub-credentials` using the Docker Hub username and an access token. Create a Multibranch Pipeline. Push `dev` for the development image and merge to `main` or `master` for the production image.

## Screenshots
Store Jenkins login/configuration/successful console, EC2 running instance, security group, Docker Hub dev/prod tags, deployed site, Prometheus target UP, and Grafana Application Health dashboard under `screenshots/`. Never expose passwords, tokens, private keys, or access keys.
