docker build -t dan361/multi-client:latest -t dan361/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dan361/multi-server:latest -t dan361/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dan361/multi-worker:latest -t dan361/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dan361/multi-client:latest
docker push dan361/multi-server:latest
docker push dan361/multi-worker:latest
docker push dan361/multi-client:$SHA
docker push dan361/multi-server:$SHA
docker push dan361/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dan361/multi-server:$SHA
kubectl set image deployments/client-deployment client=dan361/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dan361/multi-worker:$SHA
