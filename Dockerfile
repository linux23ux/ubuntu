FROM accetto/ubuntu-vnc-novnc:latest

# 2. Switch to root user to install custom packages
USER root

# Example: Install any additional tools you need (like git or curl)
RUN apt-get update && apt-get install -y \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 3. Switch back to the standard non-root user for execution security
USER 1001

# 4. Optional: Override default environment variables
ENV VNC_PW=mysecretpassword
ENV VNC_RESOLUTION=1920x1080

# Keep the base image's configuration intact
WORKDIR /dockerstartup
ENTRYPOINT ["./vnc_startup.sh"]
CMD ["--wait"]
