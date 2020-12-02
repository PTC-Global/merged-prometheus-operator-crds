This is a temporary workaround for having all prometheus-operaotr CRDs in a single file:

Follow these steps to get the file ready.

```bash
PROMETHEUS_OPERATOR_VERSION=  # e.g. v0.44.0
NEW_MERGED_CRD_FILE=prometheus-operator-crds-${PROMETHEUS_OPERATOR_VERSION:?}.yaml
test -d prometheus-operator || git clone https://github.com/prometheus-operator/prometheus-operator
pushd ./prometheus-operator; git pull -a; git co ${PROMETHEUS_OPERATOR_VERSION:?}; popd
cat ./prometheus-operator/example/prometheus-operator-crd/*.yaml > ${NEW_MERGED_CRD_FILE:?}
git add ${NEW_MERGED_CRD_FILE:?}
git commit -m "Added prometheus operator CRDs file for ${PROMETHEUS_OPERATOR_VERSION:?}"
git push
```
