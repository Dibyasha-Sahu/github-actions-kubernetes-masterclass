#!/bin/bash

echo "================================="
echo "Deployment Risk Analyzer"
echo "================================="

FILES=$(git diff --name-only HEAD~1 HEAD 2>/dev/null | wc -l)

YAML=$(git diff --name-only HEAD~1 HEAD 2>/dev/null | grep yaml | wc -l)

DOCKER=$(git diff --name-only HEAD~1 HEAD 2>/dev/null | grep Dockerfile | wc -l)

SCORE=$((FILES*10 + YAML*20 + DOCKER*30))

echo
echo "Changed files: $FILES"
echo "YAML modified: $YAML"
echo "Docker changes: $DOCKER"

echo
echo "Deployment Risk Score: $SCORE%"

if [ "$SCORE" -gt 70 ]
then
echo "High Risk Deployment"
else
echo "Safe Deployment"
fi