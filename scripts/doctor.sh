#!/bin/bash

echo "================================="
echo "Kubernetes Doctor Bot"
echo "================================="

echo
echo "Checking Pods..."
kubectl get pods -n skillpulse

echo
echo "Checking Failed Pods..."

FAILED=$(kubectl get pods -n skillpulse --no-headers | grep -E 'CrashLoopBackOff|Error|Pending')

if [ -z "$FAILED" ]
then
echo "All pods healthy"
else
echo "$FAILED"
fi

echo
echo "Checking Services..."

kubectl get svc -n skillpulse

echo
echo "Checking Cluster Events..."

kubectl get events -n skillpulse --sort-by=.metadata.creationTimestamp | tail -5

echo
echo "Diagnosis Complete"