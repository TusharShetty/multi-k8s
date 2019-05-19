#/bin/sh

docker build -t kmv834/multi-client:latest -t kmv834/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kmv834/multi-server:latest -t kmv834/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kmv834/multi-worker:latest -t kmv834/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kmv834/multi-client:$SHA
docker push kmv834/multi-client:latest
docker push kmv834/multi-server:$SHA
docker push kmv834/multi-server:latest
docker push kmv834/multi-worker:$SHA
docker push kmv834/multi-worker:latest

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=kmv834/multi-server:$SHA
kubectl set image deployments/client-deployment client=kmv834/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kmv834/multi-worker:$SHA