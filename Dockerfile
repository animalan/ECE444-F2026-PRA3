# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy and install dependencies first (for better caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code into the container
COPY . .

# Expose port 5000 so the app is accessible externally
EXPOSE 5000

ENV FLASK_APP=hello.py

# Run the Flask application
CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]