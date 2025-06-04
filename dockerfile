# Use official Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the app code
COPY . .

# Expose port
EXPOSE 8000

# Run the FastAPI app
CMD ["uvicorn", "back:app", "--host", "0.0.0.0", "--port", "8000"]
