#!/bin/bash

echo "================================="
echo "CHAOS MODE ACTIVATED"
echo "================================="

echo
echo "Selecting frontend pod..."

POD=$(kubectl get pods -n skillpulse -l app=frontend -o jsonpath="{.items[0].metadata.name}")

echo
echo "Target pod:"
echo $POD

echo
echo "Simulating failure..."

kubectl delete pod $POD -n skillpulse

echo
echo "Attack complete"
echo
echo "Kubernetes self-healing should recreate pod..."
echo
echo "Watching recovery..."

kubectl get pods -n skillpulse -w