#/bin/bash

set -e

# agent
kubectl exec -n spire spire-server-0 -- \
    /opt/spire/bin/spire-server entry create \
    -node  \
    -spiffeID spiffe://example.org/ns/spire/sa/spire-agent \
    -selector k8s_sat:cluster:demo-cluster \
    -selector k8s_sat:agent_ns:spire \
    -selector k8s_sat:agent_sa:spire-agent

# workloads
# ns/default/sa/default
kubectl exec -n spire spire-server-0 -- \
    /opt/spire/bin/spire-server entry create \
    -spiffeID spiffe://example.org/ns/default/sa/default \
    -parentID spiffe://example.org/ns/spire/sa/spire-agent \
    -selector k8s:ns:default \
    -selector k8s:sa:default \
    -ttl 60

# ns/default/sa/foo
kubectl exec -n spire spire-server-0 -- \
    /opt/spire/bin/spire-server entry create \
    -spiffeID spiffe://example.org/ns/default/sa/foo \
    -parentID spiffe://example.org/ns/spire/sa/spire-agent \
    -selector k8s:ns:default \
    -selector k8s:sa:foo \
    -ttl 60

# ns/foo/sa/default
kubectl exec -n spire spire-server-0 -- \
    /opt/spire/bin/spire-server entry create \
    -spiffeID spiffe://example.org/ns/foo/sa/default \
    -parentID spiffe://example.org/ns/spire/sa/spire-agent \
    -selector k8s:ns:foo \
    -selector k8s:sa:default

# ns/foo/sa/foo
kubectl exec -n spire spire-server-0 -- \
    /opt/spire/bin/spire-server entry create \
    -spiffeID spiffe://example.org/ns/foo/sa/foo \
    -parentID spiffe://example.org/ns/spire/sa/spire-agent \
    -selector k8s:ns:foo \
    -selector k8s:sa:foo

# ns/foo
kubectl exec -n spire spire-server-0 -- \
    /opt/spire/bin/spire-server entry create \
    -spiffeID spiffe://example.org/ns/foo \
    -parentID spiffe://example.org/ns/spire/sa/spire-agent \
    -selector k8s:ns:foo

# workloads based on image
#kubectl exec -n spire spire-server-0 -- \
#    /opt/spire/bin/spire-server entry create \
#    -spiffeID spiffe://example.org/image/ubuntu \
#    -parentID spiffe://example.org/ns/spire/sa/spire-agent \
#    -selector k8s:container-image:ubuntu:latest
#
#kubectl exec -n spire spire-server-0 -- \
#    /opt/spire/bin/spire-server entry create \
#    -spiffeID spiffe://example.org/image/praqma/network-multitool \
#    -parentID spiffe://example.org/ns/spire/sa/spire-agent \
#    -selector k8s:container-image:praqma/network-multitool:latest

# processes running in the host
kubectl exec -n spire spire-server-0 -- \
    /opt/spire/bin/spire-server entry create \
    -spiffeID spiffe://example.org/server \
    -parentID spiffe://example.org/ns/spire/sa/spire-agent \
    -selector unix:uid:1001

kubectl exec -n spire spire-server-0 -- \
    /opt/spire/bin/spire-server entry create \
    -spiffeID spiffe://example.org/client \
    -parentID spiffe://example.org/ns/spire/sa/spire-agent \
    -selector unix:uid:1002
