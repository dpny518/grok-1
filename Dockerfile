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
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Expose any necessary ports (if applicable)
# EXPOSE <port_number>

# Command to run the application
CMD ["python3", "run.py"]
