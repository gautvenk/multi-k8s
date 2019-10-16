docker build -t gautvenk/multi-client:latest -t gautvenk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gautvenk/multi-server:latest -t gautvenk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gautvenk/multi-worker:latest -t gautvenk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gautvenk/multi-client:latest
docker push gautvenk/multi-server:latest
docker push gautvenk/multi-worker:latest

docker push gautvenk/multi-client:$SHA
docker push gautvenk/multi-server:$SHA
docker push gautvenk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gautvenk/multi-server:$SHA
kubectl set image deployments/client-deployment client=gautvenk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gautvenk/multi-worker:$SHA
