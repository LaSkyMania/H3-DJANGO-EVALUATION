FROM python:3.13-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN pip install --upgrade pip && pip install -r requirements.txt

CMD ["python", "./djangoevaluation/manage.py", "runserver", "0.0.0.0:8000"]