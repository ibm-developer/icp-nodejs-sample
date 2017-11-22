helm delete --purge sample
kubectl delete pod sample-wget-test 2> /dev/null
helm install --name sample .
helm test --debug --timeout 120 sample
