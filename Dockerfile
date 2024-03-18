# Use a base image with GPU support, such as Nvidia's CUDA image
FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04

# Set the working directory in the container
WORKDIR /app

# Copy the contents of the repository to the container
COPY . .

# Install necessary packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    transmission-cli \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Use the torrent client to download the weights
RUN transmission-cli "magnet:?xt=urn:btih:5f96d43576e3d386c9ba65b883210a393b68210e&tr=https%3A%2F%2Facademictorrents.com%2Fannounce.php&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce"


# Expose any necessary ports (if applicable)
# EXPOSE <port_number>

# Command to run the application
CMD ["python3", "run.py"]
