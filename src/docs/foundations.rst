============
 Kubernetes
============
-------------------------
 Foundations for dummies
-------------------------
:Info: See <http://docutils.sf.net/rst.html> for introductory docs.
:Author: William Artero <https://scr.im/wwmoraes>
:Date: $Date: 2019-10-09 10:31:00 -0300 (Wed, 09 Oct 2019) $
:Revision: $Revision: 1 $
:Description: This material aims at demystifying and explaining what |k8s|_ is and what it's supposed to do from a very practical point of view. It is by no means a substitute of the official site and documentation. For more detailed (and formal) information, check the official sources.

.. header:: "Hope is not a strategy."
.. footer:: Read more on https://kubernetes.io/docs/

.. epigraph:: This material aims at demystifying and explaining what |k8s|_ is and what it's supposed to do from a very practical point of view. It is by no means a substitute of the official site and documentation. For more detailed (and formal) information, check the official sources.

.. sectnum::

.. contents:: table of contents


TL;DR What is `Kubernetes`?
===========================

.. figure:: ../images/kubernetes_logo.png
  :height: 64px
  :width: 64px
  :scale: 50%
  :alt: Kubernetes logo
  :target: k8s_


`Kubernetes`_ (a.k.a. k8s_) is simply a state machine that constantly adjusts itself to equals the current state with the stored desired definitions, known as the desired state. This applies for all its resources, i.e. configurations, policies, application containers and custom resources.


How does it work?
-----------------

Every time the current state changes, from the usual user applying a declaration, doing an imperative change to an internal event or change from the cluster itself, |k8s|_ will compare the current state against the desired one, and acts if something has to be changed, e.g. create and start up a Pod_, drop an old Deployment_ or update a ConfigMap_.


Why "k8s"? Doesn't that sound as "keights"?
-------------------------------------------

It sure does sound wrong, but the acronym is purely based on the character count between the 'k' and 's'::

  kubernetes
  -12345678-


Prerequisite concepts
=====================

The |k8s| platform relies on a couple of technologies to make all the orchestration and workload execution happen, and a minimal grasp of each is recommended in order to fully comprehend the whole platform concept.


Containers
----------

Made popular through a branded "orchestration", Docker, containers are a simplified usage form of some Linux kernel features, namely `namespace` and `cgroup`. To put it simply, these kernel features allows isolated process to be ran as if they were in a machine of their own, much like how the `chroot` works. The result transparently resembles a virtual machine, but has none of the overhead of running a complete OS.

`cgroup` stands for "control group", which is a feature that dates back to 2006 and isolates and limits resource usage (CPU, memory, I/O, network), allows accounting (e.g. for billing purposes) and controlling like freezing, snapshoting and stopping.

`namespace` is a feature that allows process isolation so that they cannot obtain nor access resources outside of the group.


YAML and JSON
-------------

Although |k8s| allows imperative changes to the desired state, usually it's a desired and good practice to work in a declarative way, either by writing and maintaining configuration files directly, or using a package and template tool as helm_.

|k8s| supports both YAML_ and JSON_ notations for the declaration of any of its resources.


Architecture
============

|k8s| is the name of a number of application services that, when coupled together, make the object management happen. These applications communicate between each one to get and set states, schedule changes, assign IPs, ports, routes, receive signals of events and constant monitor the cluster.

Cluster Nodes
-------------

Each host inside a |k8s| cluster is called a node. A host can be a physical machine or a VM. Each cluster is composed of at least one host, which runs both as the control plane and as a worker. Usually (and recommended), though, the cluster has a dedicated control plane host and multiple worker nodes distribute the workloads.

Control Plane node
++++++++++++++++++

The central control of the whole cluster, this node runs most of the |k8s| software, and is responsible for controlling all the worker nodes. It runs:

* kube-apiserver_
* kube-controller-manager_
* kube-scheduler_
* cloud-controller-manager_


Main API service (kube-apiserver)
.................................

Provides REST endpoints to which all other components use to interact with the cluster state. It's the main interface used to communicate with the whole cluster. Tools like `kubectl`, internal components, web interfaces and third-party solutions all interact with the cluster purely through this API.

This API also validates all objects (i.e. pod, service, deployment, etc) to ensure only valid state is stored.


Control loop daemon (kube-controller-manager)
.............................................

The core of state management, it's the main control loop that coordinates all controller actions needed to change the current shared state towards the desired state. It does so by communicating with the apiserver to query the states, and the controllers change the state whenever they complete an action. Core and third-party controllers are all bound to this loop.


Workload scheduler (kube-scheduler)
...................................

Service responsible for the definition of where a workload will be run. It does so by evaluating resource requirements, constraints, (anti-)affinity, node taints and so on. If all nodes are tied (e.g. on a new cluster or an unconstrained/untainted cluster + no pod affinity), it'll randomly choose a node.


Cloud-specific control loops (cloud-controller-manager)
.......................................................

Control loop service that allows cloud providers to create and plug platform-specific controllers to interact with their services, e.g. a controller that creates an instance of the provider's load balancer automatically for a specific |k8s|_ kind_.


Worker Nodes
++++++++++++

Workload-running capable hosts in a |k8s| cluster. These hosts are managed by the control plane apiserver, which sends the wanted routes, firewall rules and state, like which containers should be running at a given time for instance. Each node runs two |k8s| agents:

* kubelet_
* kube-proxy_


Node agent (kubelet)
....................

Agent that runs on each cluster node. It's responsible for registering the node with the cluster's apiserver and for running and keeping healthy the given Pod_ specs from apiserver (it can also run pods from a given local path, query an HTTP endpoint or act as an HTTP server to receive requests directly, but the most common way to deploy is through the apiserver).


Node network proxy (kube-proxy)
...............................

Proxy that's responsible for managing the required cluster service_ specs on the node. Sets up the node routing table, allowing and denying communication as per the specs provided. Also provides routes for forward and round robin requests between pods.

By default uses `netfilter` for setting the kernel connection parameters and setting up rules (a.k.a. `iptables`).


Networking
----------

The |k8s| network architecture aims at being the most frictionless possible. That means a vanilla |k8s| cluster, on premisses, will bridge a Pod_ into the local network, i.e. the Pod_ will have a LAN IP and use the same IP subnet of the node it runs in, exactly the same way a bridged connection from VMs and containers do.

A |k8s| cluster roughly supports up to 5,000 nodes and 150,000 pods. As each Node_ and Pod_ have an IP, a cluster can consume at most 155,000 IPs. Given that working with a Class B subnet (ranges from 128 to 191, with 16 bits masks) gives at most 65534 hosts, most large clusters will need to break down the nodes and pods allocation to multiple subnets. It's also a common security practice to create multiple isolated subnets to reduce the attack surface in case of a host breach.

|k8s| does support working with multiple subnets and cloud VLANs by implementing the `Container Network Interface`_ (CNI) and through CNI plugins. Also those plugins can change the way Pods_ communicate with each other, like using kernel filters (BPF, eBPF, XDP) and so on.

Some well-known CNI plugin names are:

* Calico_ (L3 VLAN)
* Cilium_ (BPF and XDP)
* `Amazon ECS CNI`_ (sets up EC2 instances using ENIs)
* `VMware NSX-T CNI`_ (NSX L2/L3 network, L4/L7 LB)


Objects
-------

|k8s| objects are well-defined, persistent entities that describe a containerized application, a policy or a resource that represent a state of something, be it an application environment, configuration, network policies, a user, a role, and so on. A pod object with a single nginx container looks like this:

.. code:: yaml

  apiVersion: apps/v1
  kind: Pod
  spec:
    containers:
    - name: nginx
      image: nginx:latest
      ports:
      - containerPort: 80


Object Kind
+++++++++++

Every |k8s| object has a kind, which are like classes, i.e. each one has a defined set of fields and values, required or optional, needed for that kind to be processed successfully by a controller.

The controllers watch over for changes on specific kinds that they know how to act upon. The core replication controller watches over the ReplicaSet_ kind, for instance: whenever there's a new ReplicaSet_ or a change on an existing one, the controller do it's magic.

But don't take the "defined" as granted: any kind can be stored in the cluster, even a kind completely unknown.


Object Management
+++++++++++++++++

Objects may be created and managed in multiple ways, using official and non-official tools. For instance:

* `kubectl`: imperative changes (e.g. edit an object directly, scale, set container image, etc)
* `kubectl`: declarative changes (e.g. apply a JSON, creating/updating object(s))
* `helm`: declarative changes (e.g. parse a template and apply the resulting JSON, creating/updating object(s))

Some cloud providers also allow modifying objects through its web interface. All of these tools and interfaces interact with the kube-apiserver_.

Workloads
---------

.. rubric:: TODO


Pod
+++

.. rubric:: TODO


ReplicaSet
++++++++++

.. rubric:: TODO


Deployment
++++++++++

.. rubric:: TODO


StatefulSet
+++++++++++

.. rubric:: TODO


DaemonSet
+++++++++

.. rubric:: TODO


Jobs
++++

.. rubric:: TODO


Cronjobs
++++++++

.. rubric:: TODO


Resources
---------

.. rubric:: TODO


Service
+++++++

.. rubric:: TODO


Ingress
+++++++

.. rubric:: TODO


ConfigMap
+++++++++

.. rubric:: TODO


Secret
++++++

.. rubric:: TODO


Network Policy
++++++++++++++

.. rubric:: TODO


Volume types
++++++++++++

.. rubric:: TODO


PersistentVolume
++++++++++++++++

.. rubric:: TODO


Controllers
-----------

.. rubric:: TODO


Authentication and Authorization
--------------------------------

.. rubric:: TODO


Role-Based Access Control (RBAC)
++++++++++++++++++++++++++++++++

.. rubric:: TODO


Role and ClusterRole
....................

.. rubric:: TODO


RoleBinding and ClusterRoleBinding
..................................

.. rubric:: TODO


Operation
=========

.. rubric:: TODO


Tools
-----

.. rubric:: TODO


kubectl
+++++++

.. rubric:: TODO


helm
++++

.. rubric:: TODO


Deployment strategies
---------------------

.. rubric:: TODO


Rolling update
++++++++++++++

.. rubric:: TODO


Blue-green
++++++++++

.. rubric:: TODO


Canary
++++++

.. rubric:: TODO


Scaling
-------

.. rubric:: TODO


Cluster Scaling
+++++++++++++++

.. rubric:: TODO


Pod Autoscaling
+++++++++++++++

.. rubric:: TODO


Pod placement
-------------

.. rubric:: TODO


[Anti-]Affinity
+++++++++++++++

.. rubric:: TODO


Node taints and tolerations
+++++++++++++++++++++++++++

.. rubric:: TODO


.. #############################################################################
.. replaces

.. |k8s| replace:: Kubernetes

.. #############################################################################
.. links

.. _k8s: https://kubernetes.io/docs/home/
.. _helm: https://helm.sh/
.. _yaml: https://yaml.org/
.. _json: http://www.json.org/
.. _pod: https://kubernetes.io/docs/concepts/workloads/pods/pod/
.. _configmap: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
.. _kube-apiserver: https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/
.. _kube-controller-manager: https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/
.. _kube-scheduler: https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/
.. _cloud-controller-manager: https://kubernetes.io/docs/reference/command-line-tools-reference/cloud-controller-manager/
.. _kubelet: https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/
.. _kube-proxy: https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/
.. _kind: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
.. _node: https://kubernetes.io/docs/concepts/architecture/nodes/
.. _CNI: https://github.com/containernetworking/cni
.. _container network interface: https://github.com/containernetworking/cni
.. _calico: https://github.com/projectcalico/cni-plugin
.. _cilium: https://github.com/cilium/cilium
.. _amazon ecs cni: https://github.com/aws/amazon-ecs-cni-plugins
.. _vmware nsx-t cni: https://docs.vmware.com/en/VMware-NSX-T-Data-Center/2.2/com.vmware.nsxt.ncp_kubernetes.doc/GUID-6AFA724E-BB62-4693-B95C-321E8DDEA7E1.html

.. #############################################################################
.. retargets

.. _pods: pod_
