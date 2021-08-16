.PHONY: build

build : sm_cli sm_container

define pull_secman
		@cd cli && \
		wget https://docker.secman.dev/secman && \
		chmod 755 secman
endef

pull:
		$(call pull_secman)

sm_cli:
		$(call pull_secman)

		@cd cli && \
		docker build -t smcr/secman-cli . && \
		docker push smcr/secman-cli

sm_container:
		@cd container && \
		docker build -t smcr/secman . && \
		docker push smcr/secman
