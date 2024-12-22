# @author alberterc 

FROM debian:latest

ENV NODE_INSTALL_VERSION=22

# Update and install software
RUN apt-get update && apt-get install -y \
	ca-certificates \
	bash \
	unzip \
	curl \
	git

SHELL ["/bin/bash", "-c"]

# Install fnm for node version manager
RUN curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "/opt" --skip-shell && \
	ln -s /opt/fnm /usr/bin/ && chmod +x /usr/bin/fnm && \
	echo 'eval "$(fnm env --use-on-cd --shell bash)"' >> /root/.bashrc && \
	# Install and enable node
	source /root/.bashrc && fnm use --install-if-missing ${NODE_INSTALL_VERSION}

# Install dfx
RUN DFXVM_INIT_YES=true sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"

# Prevent container from exit
CMD ["tail", "-f", "/dev/null"]