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

Concepts
========

Control Plane
-------------

.. rubric:: TODO

Object Management
-----------------

.. rubric:: TODO

Workloads
+++++++++

.. rubric:: TODO

Controllers
+++++++++++

.. rubric:: TODO

.. |k8s| replace:: kubernetes
.. _k8s: https://kubernetes.io/docs/home/
.. _pod: https://kubernetes.io/docs/concepts/workloads/pods/pod/
.. _configmap: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
