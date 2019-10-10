============
 Kubernetes
============
-------------------------
 Foundations for dummies
-------------------------
:Info: See <http://docutils.sf.net/rst.html> for introductory docs.
:Author: William Artero <william.artero@dafiti.com.br>
:Date: $Date: 2019-10-09 10:31:00 -0300 (Wed, 09 Oct 2019) $
:Revision: $Revision: 1 $
:Description: docinfo block/bibliographic field list

.. header:: Kubernetes - Foundations for dummies - Dafiti Group
.. footer:: https://github.com/dafiti-group/k8s-101

.. epigraph:: This material aims at demystifying and explaining what |k8s|_ is and what it's supposed to do from a very practical point of view. It is by no means a substitute of the official site and documentation. For more detailed (and formal) information, check the official sources.

.. sectnum::

.. contents:: table of contents


TL;DR What is `Kubernetes`?
===========================

`Kubernetes`_ (a.k.a. k8s_) is simply a state machine that constantly adjusts itself to equals the current state with the stored desired definitions, known as the desired state.


How does it work?
-----------------

Every time the current state changes, from the usual user applying a declaration, doing an imperative change to an internal event or change from the cluster itself, k8s_ will compare the current state against the desired one, and acts if something has to be changed, e.g. create and start up a Pod_ or update a ConfigMap_.


Why "k8s"? Doesn't that sound as "keights"?
-------------------------------------------


Concepts
========


Containers
----------


YAML and JSON
-------------

.. rubric:: TODO


Architecture
============

.. rubric:: TODO


Control Plane
-------------

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


.. |k8s| replace:: kubernetes
.. _k8s: https://kubernetes.io/docs/home/
.. _pod: https://kubernetes.io/docs/concepts/workloads/pods/pod/
.. _configmap: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
