# Use a base image with GPU support, such as Nvidia's CUDA image
FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04

# Set the working directory in the container
WORKDIR /app

# Clone the repository and install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Clone the GitHub repository
RUN git clone https://github.com/xai-org/grok-1.git

# Navigate into the cloned repository and install dependencies
WORKDIR /app/grok-1
RUN pip install huggingface_hub[hf_transfer]
RUN huggingface-cli download xai-org/grok-1 --repo-type model --include ckpt-0/* --local-dir checkpoints --local-dir-use-symlinks False

# Navigate back to the working directory
WORKDIR /app

# Copy the contents of the local directory to the container
COPY . .

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Expose any necessary ports (if applicable)
# EXPOSE <port_number>

# Command to run the application
CMD ["python3", "run.py"]
