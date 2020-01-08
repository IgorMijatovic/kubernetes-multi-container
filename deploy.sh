# build all our images, tag each one and push to docker hub
docker build -t imijatovic/multi-client:latest -t imijatovic/multi-client:$GIT-COMMIT -f ./client/Dockerfile ./client 
docker build -t imijatovic/multi-server:latest -t imijatovic/multi-server:$GIT-COMMIT -f ./server/Dockerfile ./server  
docker build -t imijatovic/multi-worker:latest -t imijatovic/multi-worker:$GIT-COMMIT -f ./worker/Dockerfile ./worker  

docker push imijatovic/multi-client:latest
docker push imijatovic/multi-server:latest
docker push imijatovic/multi-worker:latest

docker push imijatovic/multi-client:$GIT-COMMIT
docker push imijatovic/multi-server:$GIT-COMMIT
docker push imijatovic/multi-worker:$GIT-COMMIT

# aoply all configs to the k8s folder
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=imijatovic/multi-server:$GIT-COMMIT
kubectl set image deployments/client-deployment client=imijatovic/multi-client:$GIT-COMMIT
kubectl set image deployments/worker-deployment worker=imijatovic/multi-worker:$GIT-COMMIT