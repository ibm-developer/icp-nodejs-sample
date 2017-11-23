helm delete --purge sample 2> /dev/null
kubectl delete pod sample-main-endpoint-test 2> /dev/null
kubectl delete pod sample-metrics-endpoint-test 2> /dev/null
kubectl delete pod sample-dash-endpoint-test 2> /dev/null
kubectl delete pod sample-stays-up-test 2> /dev/null

sleep 10

helm install --name sample .

sleep 10

helm test --cleanup --debug --timeout 30 sample
