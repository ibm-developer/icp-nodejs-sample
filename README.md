# Node.js sample Helm Chart

### This sample is for demonstrative purposes only and is NOT for production use! ###

This sample application is intended to guide you through the process of deploying your own Node.js applications into IBM Cloud Private. Useful links and examples are provided and the application itself is one that makes use of various monitoring capabilities.

This sample was created using `idt create` with the following choices:
- Web App
- Basic Web
- Node

Note that this was done in October 2017 and so the generators may have changed since then - you shouldn't expect all files here to be identical to those provided by the generators.

Modifications were then made to use EJS, to add a gulp task, and to add the content. The stylesheet provided is largely based on the [Node.js @ IBM developer center](https://developer.ibm.com/node).

- This example uses [appmetrics](https://github.com/RuntimeTools/appmetrics) and [appmetrics-dash](https://github.com/RuntimeTools/appmetrics-dash): the endpoint being `/appmetrics-dash`.
- This example features the "scrape" annotation in the `chart/templates/service.yaml` file. In combination with the [appmetrics-prometheus](https://github.com/RuntimeTools/appmetrics-prometheus) module inclusion and usage, this enables the sample to be automatically scraped by a deployed instance of Prometheus in order for metrics to be gathered and displayed using the Prometheus web UI. You can view the raw data that will be available to Prometheus at the `/metrics` endpoint.
This allows developers to quickly determine how the application is performing across potentially many Kubernetes pods.

- This example can be deployed using the IBM Cloud Developer Tools, for example: `idt deploy -t container --deploy-image-target mycluster.icp:8500/default/nodejs-sample`.

The `mycluster.icp` example here should match up with the entry you've added in `/etc/hosts`: it is the location of the private registry.

## Requirements

There is only one optional requirement to make the most out of this sample: you should have Prometheus deployed into your IBM Cloud Private cluster where this sample will be installed. This is not a mandatory step and can be done after deployment, happy installing!

## Configuration

The Helm chart can be installed from the app center by finding the ibm-nodejs-sample entry and following the installation steps.

The Helm chart can also be installed with the following command from the directory containing `Chart.yaml`:

`helm install --name nodejs-sample .`

You can find more information about deployment methods in the [IBM Cloud Private documentation](https://www.ibm.com/support/knowledgecenter/SSBS6K/product_welcome_cloud_private.html).

## Accessing the Node.js sample

From a browser, use http://*external ip*:*nodeport* to access the application.

##### Configuring Node.js within IBM Cloud Private

See the [Node.js @ IBM developer center](https://developer.ibm.com/node/) for all things Node.js - including more samples, tutorials and blog posts. For configuring Node.js itself, consult the official [Node.js community documentation](https://nodejs.org/en/docs/).
