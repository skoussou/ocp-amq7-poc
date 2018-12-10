#!/bin/bash

oc login -u system:admin

# Delete the project where AMQ Online is deployed:

oc delete project amq-online-infra

# Delete the rolebinding in the kube-system namespace:
oc delete rolebindings -l app=enmasse -n kube-system

# Delete "cluster level" resources:

oc delete clusterrolebindings -l app=enmasse
oc delete clusterroles -l app=enmasse
oc delete apiservices -l app=enmasse
oc delete oauthclients -l app=enmasse

# (Optional) Delete the service catalog integration:

oc delete clusterservicebrokers -l app=enmasse
