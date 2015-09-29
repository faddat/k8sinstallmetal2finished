# Scenario:

You have a cluster (GKE) on google, now you need to connect to it and access the API.   You don't have gcloud tools installed.

### Vagrant link

https://github.com/kubernetes/kubernetes/blob/master/Vagrantfile

### Server Info because cheating is great
```
$ gcloud container clusters create chicken -m n1-highmem-2
NAME     ZONE           MASTER_VERSION  MASTER_IP        MACHINE_TYPE  STATUS
chicken  us-central1-f  1.0.6           130.211.112.181  n1-highmem-2  RUNNING

$ gcloud compute instances list
NAME                           ZONE          MACHINE_TYPE PREEMPTIBLE INTERNAL_IP EXTERNAL_IP     STATUS
gke-chicken-13d25c52-node-bo3j us-central1-f n1-highmem-2             10.240.0.4  104.197.135.124 RUNNING
gke-chicken-13d25c52-node-ppwf us-central1-f n1-highmem-2             10.240.0.3  146.148.73.102  RUNNING
gke-chicken-13d25c52-node-y90z us-central1-f n1-highmem-2             10.240.0.2  104.197.69.57   RUNNING
```
 * The master is always the API server


## To get the credentials for the server:

 1. install Gcloud
 ```
  * curl https://sdk.cloud.google.com | bash
```
 2. Update the gcloud components
```
gcloud components update kubectl alpha beta preview app-engine-java app-engine-php-linux app-engine-python bq core gsutil gcloud kubectl
```
 3. Login
```
gcloud auth login
```
 4. Test to see that logging in worked
```
gcloud container clusters list
```
 5. Grab yoself some credentials
```
gcloud container clusters get-credentials
```
 6. Test to see if the credentials done took hold
```
kubectl get pods
```
 7. 2nd test to see if the credentials done took hold in ya's sky computar
```
kubectl cluster-info
```
which should print something like:
```
Kubernetes master is running at https://130.211.112.181
KubeDNS is running at https://130.211.112.181/api/v1/proxy/namespaces/kube-system/services/kube-dns
KubeUI is running at https://130.211.112.181/api/v1/proxy/namespaces/kube-system/services/kube-ui
Heapster is running at https://130.211.112.181/api/v1/proxy/namespaces/kube-system/services/monitoring-heapster
```
 * Password for these URLs is: lllAFGrWDvqXJY4E

Fabric8 Deploy:
export FABRIC8_PROFILES=kubernetes
kc get pods
kc create -f http://central.maven.org/maven2/io/fabric8/apps/console-kubernetes/2.2.19/console-kubernetes-2.2.19-kubernetes.json
