### This is where the file for multi-arch support will be provided.

See [here](https://github.com/docker/cli/pull/138) for details.

Interim solution:
Follow the instructions [here](https://github.com/estesp/manifest-tool).

- `export PATH=$GOPATH/src/github.com/estesp/manifest-tool:$PATH`
- `docker login`
- `manifest-tool push from-spec multiarch.yml`
