# Helm
SRC_ROOT = $(shell git rev-parse --show-toplevel)

helm-docs: HELMDOCS_VERSION := v1.11.0
helm-docs: docker
	@docker run -v "$(SRC_ROOT):/helm-docs" jnorwood/helm-docs:$(HELMDOCS_VERSION) --chart-search-root /helm-docs

# Tested Versions
HELM_VERSIONS = v3.5.4 v3.6.3 v3.7.1 v3.8.2

# Uses Helm Version as parameter (eg. make lint/v3.8.0)
.PHONY: lint
lint/%: docker
	@echo  "\n\033[0;31mLinting Helm Chart with Helm $(*)\033[0m\n"
	@docker run -v "$(SRC_ROOT):/workdir" --entrypoint /bin/sh --platform linux/amd64 quay.io/helmpack/chart-testing:v3.3.1 \
	-c "curl -s https://get.helm.sh/helm-$*-linux-amd64.tar.gz | tar zx && mv linux-amd64/helm /usr/local/bin/helm && cd /workdir && ct lint --config ./charts/ct.yaml --lint-conf ./charts/lint.yaml --all --debug"

# Lint all versions
lint-all: $(foreach HELM_VERSION,$(HELM_VERSIONS),lint/$(HELM_VERSION))

# Uses Helm Version as parameter (eg. make unit-test/v3.8.0)
.PHONY: unit-test
unit-test/%: docker helm-locks
	@echo "\n\033[0;31mRunning unit tests for Helm $(*)\033[0m\n"
	@docker run -v "$(SRC_ROOT):/workdir" --entrypoint /bin/sh --platform linux/amd64 quay.io/helmpack/chart-testing:v3.3.1 \
	-c "curl -s https://get.helm.sh/helm-$*-linux-amd64.tar.gz | tar zx && mv linux-amd64/helm /usr/local/bin/helm && cd /workdir && helm plugin install https://github.com/quintush/helm-unittest > /dev/null || true && ct lint --config ./examples/ct.yaml --lint-conf ./charts/lint.yaml --all --debug"

# Unit test all versions
unit-test-all: $(foreach HELM_VERSION,$(HELM_VERSIONS),unit-test/$(HELM_VERSION))

# Remove Helm Locks
.PHONY: helm-locks
helm-locks:
	find "$(SRC_ROOT)/examples" -name Chart.lock -type f -delete

docker:
	@hash docker 2>/dev/null || {\
		echo "You need docker" &&\
		exit 1;\
	}