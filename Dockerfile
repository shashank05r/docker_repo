# Step 1: Use the official Terraform image as the base
FROM hashicorp/terraform:1.8.4

# Step 2: Set the working directory inside the container
WORKDIR /infra

# Step 3: Copy your Terraform files into the container
COPY . .

# Step 4: Set the default command (optional, can override)
ENTRYPOINT ["terraform"]
