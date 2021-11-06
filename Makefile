.PHONY: build

build : sm_cli sm_container

sm_cli:
		@cd cli && \
		docker build -t smcr/secman-cli . && \
		docker push smcr/secman-cli

sm_container:
		@cd container && \
		docker build -t smcr/secman . && \
		docker push smcr/secman
