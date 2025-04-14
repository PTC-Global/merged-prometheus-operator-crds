SCRIPT := ./generate-crds.sh

# Default target
.PHONY: generate
generate:
	@echo "Usage: make generate-crds VERSION=<prometheus-operator-version>"

# Generate the minified CRDs for the specified Prometheus Operator version
.PHONY: generate-crds
generate-crds:
ifndef VERSION
	$(error VERSION is not set. Usage: make generate-crds VERSION=v0.70.0)
endif
	$(SCRIPT) $(VERSION)
