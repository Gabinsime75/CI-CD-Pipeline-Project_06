FROM python:3.9.16-slim-buster
# This instruction sets the base image for the Docker image. It specifies that the image
#should be based on the official Python image with version 3.9.16, which is using the 
#"slim" variant of the Debian-based "buster" distribution. The slim variant contains
#fewer unnecessary packages, making the resulting image smaller.

WORKDIR /app
# This instruction sets the working directory inside the container to /app.
# This is the directory where subsequent commands will be executed.

COPY required_versions.txt .
# This instruction copies the file named required_versions.txt from the host
# machine (the same directory as the Dockerfile) to the current working directory 
# (/app) in the container.

RUN pip3 install --no-cache-dir -r required_versions.txt
# This instruction runs a command within the container to install Python packages listed
# in the required_versions.txt file using pip3. The --no-cache-dir flag 
# prevents caching of downloaded package files. This step is typically used to install 
# dependencies required by the application.

COPY . .
# This instruction copies all files and directories from the host machine 
# (the same directory as the Dockerfile) to the current working directory 
# (/app) in the container. This includes the actual application code.

ENV FLASK_APP="myapp.py"
# This instruction sets an environment variable named FLASK_APP to "myapp.py". 
# This environment variable specifies the entry point for the Flask application within 
# the container.
EXPOSE 5000
# This instruction declares that the container will expose port 5000. This doesn't 
# actually publish the port to the host machine; it's just informational for anyone 
# running the container to know which ports to map.

CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]
# This instruction specifies the command that will be executed when the container is run. 
# It launches the Flask application using the flask module's run subcommand. 
# The --host=0.0.0.0 argument allows the Flask app to be accessible externally, not just 
# from within the container.