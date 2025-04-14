#!/bin/bash
set -euo pipefail

usage() {
  echo "Usage: $0 <prometheus-operator-version>"
  echo "Example: $0 v0.44.0"
  exit 1
}

# Ensure a version is provided
if [ "$#" -ne 1 ]; then
  usage
fi

PROMETHEUS_OPERATOR_VERSION="$1"
NEW_MERGED_CRD_FILE="prometheus-operator-crds-${PROMETHEUS_OPERATOR_VERSION}.yaml"
MERGED_MINIFIED_CRD_FILE="${NEW_MERGED_CRD_FILE/.yaml/-minified.yaml}"

# Start from latest master
git checkout master
git pull

# Clone repo if not present
if [ ! -d prometheus-operator ]; then
  git clone https://github.com/prometheus-operator/prometheus-operator
fi

# Checkout the desired version
pushd prometheus-operator > /dev/null
git fetch origin
git checkout "${PROMETHEUS_OPERATOR_VERSION}"
popd > /dev/null

# Merge CRD YAML files
cat prometheus-operator/example/prometheus-operator-crd/*.yaml > "${NEW_MERGED_CRD_FILE}"

# Minify the merged CRD file
yq eval 'del(.. | .description?, .metadata.creationTimestamp?)' "${NEW_MERGED_CRD_FILE}" > "${MERGED_MINIFIED_CRD_FILE}"

# Commit and push to a new branch
git checkout -b "${PROMETHEUS_OPERATOR_VERSION}"
git add "${NEW_MERGED_CRD_FILE}" "${MERGED_MINIFIED_CRD_FILE}"
git commit -m "Add Prometheus Operator CRDs for ${PROMETHEUS_OPERATOR_VERSION}"
git push --set-upstream origin "${PROMETHEUS_OPERATOR_VERSION}"
