#!/bin/bash

echo "Create Service Account amq-service-account in namespace amq-pocs"
echo '{"kind": "ServiceAccount", "apiVersion": "v1", "metadata": {"name": "amq-service-account"}}' | oc create -f - -n amq-pocs

echo "Add the view role to the service account. The view role enables the service account to view all the resources in the amq-demo namespace, which is necessary for managing the cluster when using the OpenShift dns-ping protocol for discovering the mesh endpoints."

oc policy add-role-to-user view system:serviceaccount:amq-pocs:amq-service-account -n amq-pocs

echo "Use the broker keystore file to create the AMQ Broker secret:"
# oc secrets new amq-app-secret broker.ks
oc create secret generic amq-app-secret --from-file=./certs/broker.ks --from-file=./certs/broker.ts  -n amq-pocs

echo "Add the secret to the service account created earlier:"
oc secrets add sa/amq-service-account secret/amq-app-secret  -n amq-pocs
