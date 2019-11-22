#!/bin/sh
oc apply -f https://github.com/tektoncd/pipeline/releases/download/v0.8.0/release.yaml
oc apply -f https://github.com/tektoncd/triggers/releases/download/v0.1.0/release.yaml
oc apply -f ~/quayio-secret.yaml
oc new-project cicd-environment
oc adm policy add-scc-to-user privileged -z demo-sa
oc adm policy add-role-to-user edit -z demo-sa
oc apply -f serviceaccount
oc apply -f templatesandbindings
oc apply -f interceptor
oc apply -f eventlisteners
oc apply -f ../build
echo "the following commands will need to be executed when the containers are all running"
echo "oc port-forward svc/el-cicd-event-listener 8080"
echo "./demo.sh"
echo "tkn pipelinerun list"
