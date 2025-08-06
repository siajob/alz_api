# Utiliser l'image officielle Python 3.10 slim
FROM python:3.10-slim

# Installer les dépendances système nécessaires pour OpenCV et libgthread
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier des dépendances Python
COPY requirements.txt .

# Mettre à jour pip et installer les dépendances Python
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copier tout le contenu de ton projet dans le conteneur
COPY . .

# Commande pour lancer l’application avec Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]
