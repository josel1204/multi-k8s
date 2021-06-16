 docker build -t josel1204/multi-client:latest -t josel1204/multi-client:$SHA -f ./client/Dockerfile ./client
 docker build -t josel1204/multi-server:latest -t josel1204/multi-server:$SHA -f ./server/Dockerfile ./server
 docker build -t josel1204/multi-worker:latest -t josel1204/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push josel1204/multi-client:latest
docker push josel1204/multi-server:latest
docker push josel1204/multi-worker:latest

docker push josel1204/multi-client:$SHA
docker push josel1204/multi-server:$SHA
docker push josel1204/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=josel1204/multi-server:$SHA
kubectl set image deployments/client-deployment client=josel1204/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=josel1204/multi-worker:$SHA