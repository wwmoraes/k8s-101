# k8s-101

> practical and TL;DR kubernetes training

Documents, presentations and hands-on premade files to help anyone learn kubernetes the easy way.

## Getting started

The docs are made using reStructuredText, so you may need to install the rst pip packages:

```sh
pip install rst2html5 rst2html5slides
```

Usually linux distros have `rst2html5` installed through `docutils-common`, but not `rst2html5slides`.

### Building

You can then easily built using the make:

```sh
make [docs]
```

This will create the dist/html and dist/latex directories containing HTML and LaTeX files.

## Links

- Project homepage: https://github.com/dafiti-group/k8s-101
- Repository: https://github.com/dafiti-group/k8s-101
- Issue tracker: https://github.com/dafiti-group/k8s-101/issues
- Related projects:
  - [GCP Training](https://github.com/GoogleCloudPlatformTraining/training-data-analyst)
  - [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/)
  - [Google Kubernetes Engine - Quickstart](https://cloud.google.com/kubernetes-engine/docs/quickstart)

## Licensing

The code in this project is licensed under Apache 2.0 license.
