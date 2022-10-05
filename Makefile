# Helm
SRC_ROOT = $(shell git rev-parse --show-toplevel)

helm-docs: HELMDOCS_VERSION := v1.11.0
helm-docs: docker
	@docker run -v "$(SRC_ROOT):/helm-docs" jnorwood/helm-docs:$(HELMDOCS_VERSION) --chart-search-root /helm-docs

# Uses Helm Version as parameter (eg. make lint/v3.8.0)
.PHONY: lint
lint/%: docker
	@docker run -v "$(SRC_ROOT):/workdir" --entrypoint /bin/sh --platform linux/amd64 quay.io/helmpack/chart-testing:v3.3.1 \
	-c "curl -s https://get.helm.sh/helm-$*-linux-amd64.tar.gz | tar zx && mv linux-amd64/helm /usr/local/bin/helm && cd /workdir && ct lint --config ./charts/ct.yaml --lint-conf ./charts/lint.yaml --lint-conf ./charts/lint.yaml --all --debug"

# Uses Helm Version as parameter (eg. make unit-test/v3.8.0)
.PHONY: unit-test
unit-test/%: docker helm-locks
	docker run -v "$(SRC_ROOT):/workdir" --entrypoint /bin/sh --platform linux/amd64 quay.io/helmpack/chart-testing:v3.3.1 \
	-c "curl -s https://get.helm.sh/helm-$*-linux-amd64.tar.gz | tar zx && mv linux-amd64/helm /usr/local/bin/helm && cd /workdir && helm plugin install https://github.com/quintush/helm-unittest > /dev/null || true && ct lint --config ./examples/ct.yaml --lint-conf ./charts/lint.yaml --all --debug"

# Remove Helm Locks
.PHONY: helm-locks
helm-locks:
	find "$(SRC_ROOT)/examples" -name Chart.lock -type f -delete

docker:
	@hash docker 2>/dev/null || {\
		echo "You need docker" &&\
		exit 1;\
	}