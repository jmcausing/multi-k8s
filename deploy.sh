docker build -t jmcausing1/multi-client-k8s:latest -t jmcausing1/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t jmcausing1/multi-server-k8s-pgfix:latest -t jmcausing1/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t jmcausing1/multi-worker-k8s:latest -t jmcausing1/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push jmcausing1/multi-client-k8s:latest
docker push jmcausing1/multi-server-k8s-pgfix:latest
docker push jmcausing1/multi-worker-k8s:latest
 
docker push jmcausing1/multi-client-k8s:$SHA
docker push jmcausing1/multi-server-k8s-pgfix:$SHA
docker push jmcausing1/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jmcausing1/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=jmcausing1/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=jmcausing1/multi-worker-k8s:$SHA