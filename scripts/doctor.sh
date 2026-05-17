#!/bin/bash

echo "================================="
echo "Kubernetes Doctor Bot"
echo "================================="

echo
echo "[1] Checking Pods..."
kubectl get pods -n skillpulse

echo
echo "[2] Checking Failed Pods..."

FAILED=$(kubectl get pods -n skillpulse --no-headers | grep -E 'CrashLoopBackOff|Error|Pending')

if [ -z "$FAILED" ]
then
    echo "All pods healthy"
    HEALTH="HEALTHY"
else
    echo "Issues detected:"
    echo "$FAILED"
    HEALTH="UNHEALTHY"
fi

echo
echo "[3] Checking Services..."
kubectl get svc -n skillpulse

echo
echo "[4] Latest Cluster Events..."
kubectl get events -n skillpulse --sort-by=.metadata.creationTimestamp | tail -5

echo
echo "================================="
echo "Diagnosis Summary"
echo "================================="

POD_COUNT=$(kubectl get pods -n skillpulse --no-headers | wc -l)

echo "Pods Monitored: $POD_COUNT"

if [ "$HEALTH" = "HEALTHY" ]
then
    echo "Cluster Status: Stable"
    echo "Recovery State: Successful"
    echo "Recommendation: No action required"
else
    echo "Cluster Status: Needs Attention"
    echo "Recovery State: Failed"
    echo "Recommendation: Investigate workload health"
fi

echo
echo "Doctor Bot Analysis Complete"