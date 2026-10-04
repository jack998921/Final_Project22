# AI Career Navigator - Streamlit app image
# Use the same Python major.minor version you trained the model with.
FROM python:3.11-slim

# All commands below run from /app inside the container
WORKDIR /app

# Print logs immediately; don't write .pyc files
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# 1) Install libraries first, so Docker can reuse this slow step
#    when only your code changes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 2) Copy only what the app needs at runtime
COPY app.py .
COPY src/ src/
COPY models/ models/

# Streamlit's port
EXPOSE 8501

# 0.0.0.0 lets your browser reach the app from outside the container
CMD ["streamlit", "run", "app.py", \
     "--server.port=8501", \
     "--server.address=0.0.0.0", \
     "--server.headless=true", \
     "--browser.gatherUsageStats=false"]
     