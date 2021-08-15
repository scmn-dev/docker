.PHONY: build

build : sm_cli sm_container

sm_cli:
		@cd cli && \
		docker build -t smcr/secman-cli . && \
		docker push smcr/secman-cli

sm_container:
		@cd container && \
		docker build -t smcr/secman-container . && \
		docker push smcr/secman-container

pull_secman:
		@cd cli && \
		wget https://docker.secman.dev/secman && \
		chmod 755 secman
