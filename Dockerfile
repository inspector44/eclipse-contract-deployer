# Use the official Ubuntu base image
FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install packages
RUN apt-get update && \
    apt-get install -y curl sudo git nano expect build-essential

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install Yarn
RUN npm install -g yarn

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Copy the script into the container
COPY setup_script.sh /usr/local/bin/setup_script.sh
RUN chmod +x /usr/local/bin/setup_script.sh

# Reset the environment variable back
ENV DEBIAN_FRONTEND=

# Set the default command to execute the script when creating a new container
CMD ["/usr/local/bin/setup_script.sh"]
