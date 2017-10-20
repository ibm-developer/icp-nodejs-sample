### This is where the file for multi-arch support is provided.

The objective of using a multi-arch Docker image is that users won't need to modify the nodeSelector tag in the Helm chart.

See [here](https://github.com/docker/cli/pull/138) for details on how this works.

Interim solution:
Follow the instructions [here](https://github.com/estesp/manifest-tool).

- `export PATH=$GOPATH/src/github.com/estesp/manifest-tool:$PATH`
- `docker login`
- `manifest-tool push from-spec multiarch.yml`

Point to the prod or test folders as appropriate.
