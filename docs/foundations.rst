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

.. header:: Kubernetes - Foundations for dummies
.. footer:: https://github.com/dafiti-group/k8s-101

.. epigraph:: "Hope is not a strategy."

.. sectnum::

.. contents:: table of contents


TL;DR What is `Kubernetes`?
===========================

`Kubernetes`_ (a.k.a. k8s_) is simply a state machine that constantly adjusts itself to equals the current state with the stored desired definitions, known as the desired state.


How does it work?
-----------------

Every time the current state changes, from the usual user applying a declaration, doing an imperative change to an internal event or change from the cluster itself, |k8s|_ will compare the current state against the desired one, and acts if something has to be changed, e.g. create and start up a Pod_ or update a ConfigMap_.


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

Cluster
-------

A |k8s| cluster is composed of at least one machine, which runs both as the control plane and as a node. Usually (and recommended), though, the cluster has a dedicated machine for the control plane, and multiple node machines to distribute the workloads.


Control Plane
+++++++++++++

As the name suggests, it's the central control of the whole cluster. In this machine runs most of the |k8s| software:

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

.. rubric:: TODO


Workload scheduler (kube-scheduler)
...................................

.. rubric:: TODO


Cloud-specific control loops (cloud-controller-manager)
.......................................................

.. rubric:: TODO


Nodes
+++++

.. rubric:: TODO

* kubelet_
* kube-proxy_


Node agent (kubelet)
....................

.. rubric:: TODO


Node network proxy (kube-proxy)
...............................

.. rubric:: TODO


Networking
----------

.. rubric:: TODO


Object Management
-----------------

.. rubric:: TODO


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


.. |k8s| replace:: Kubernetes
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
