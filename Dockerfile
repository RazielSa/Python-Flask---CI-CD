# Use an official Python runtime as a parent image
FROM python:3.10-slim

LABEL Name="Python Flask Demo App" Version=1.0.0
LABEL org.opencontainers.image.source = "https://gitlab.com/razielsa/python-flask-cicd-dev"

ARG srcDir=src
WORKDIR /app

# Install build-essential and python3-dev to resolve compilation issues
RUN apt-get update && apt-get install -y build-essential python3-dev

# Copy requirements.txt separately and install dependencies
COPY $srcDir/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY $srcDir/run.py .
COPY $srcDir/app ./app

EXPOSE 5000

CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app"]
