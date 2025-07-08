FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y software-properties-common

# Agregar PPA para Python 3.13 (deadsnakes)
RUN add-apt-repository ppa:deadsnakes/ppa && apt-get update

# Instalar Python 3.13 y herramientas necesarias
RUN apt-get install -y \
    python3.13 \
    python3.13-venv \
    python3.13-dev \
    python3-pip \
    build-essential \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Actualizar alternativas para usar python3 y pip3 apuntando a 3.13
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 1
# RUN update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3 1

WORKDIR /app

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
