#/bin/sh

docker build -t tusharshetty/multi-client:latest -t tusharshetty/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tusharshetty/multi-server:latest -t tusharshetty/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tusharshetty/multi-worker:latest -t tusharshetty/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tusharshetty/multi-client:$SHA
docker push tusharshetty/multi-client:latest
docker push tusharshetty/multi-server:$SHA
docker push tusharshetty/multi-server:latest
docker push tusharshetty/multi-worker:$SHA
docker push tusharshetty/multi-worker:latest

kubectl apply -f k8s

kubectl set image deployments/server-deployments server=tusharshetty/multi-server:$SHA
kubectl set image deployments/client-deployments client=tusharshetty/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=tusharshetty/multi-worker:$SHA