# Usamos una imagen ligera de Python 3.11
FROM python:3.11-slim

# Instalamos herramientas básicas para compilación y curl
RUN apt-get update && apt-get install -y build-essential python3-dev curl && rm -rf /var/lib/apt/lists/*

# Instalamos Rust (para paquetes que usan maturin/cargo)
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Añadimos Rust al PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Definimos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos el archivo de dependencias
COPY requirements.txt .

# Actualizamos pip, setuptools y wheel
RUN pip install --upgrade pip setuptools wheel

# Instalamos las dependencias Python
RUN pip install -r requirements.txt

# Copiamos el resto del código de la aplicación
COPY . .

# Exponemos el puerto que usa la app (ajusta según tu app)
EXPOSE 8000

# Comando para ejecutar la app (ajusta si usas otro framework)
CMD ["python", "app.py"]
