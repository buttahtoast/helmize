# Helm
SRC_ROOT = $(shell git rev-parse --show-toplevel)

helm-docs: HELMDOCS_VERSION := v1.11.0
helm-docs: docker
	@docker run -v "$(SRC_ROOT):/helm-docs" jnorwood/helm-docs:$(HELMDOCS_VERSION) --chart-search-root /helm-docs

lint: docker
	@docker run -v "$(SRC_ROOT):/workdir" --entrypoint /bin/sh quay.io/helmpack/chart-testing:v3.3.1 -c cd /workdir && ct lint --config ./charts/ct.yaml --lint-conf ./charts/lint.yaml --all --debug
	@docker run -v "$(SRC_ROOT):/workdir" --entrypoint /bin/sh quay.io/helmpack/chart-testing:v3.3.1 -c cd /workdir && ct lint --config ./examples/ct.yaml --all --debug

unit-test: docker

docker:
	@hash docker 2>/dev/null || {\
		echo "You need docker" &&\
		exit 1;\
	}