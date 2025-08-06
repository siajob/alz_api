# Utilise une image Python légère
FROM python:3.10-slim

# Installer les dépendances système nécessaires (libGL pour OpenCV)
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Définir le dossier de travail dans le conteneur
WORKDIR /app

# Copier le fichier requirements.txt dans le conteneur
COPY requirements.txt .

# Mettre à jour pip et installer les dépendances Python
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste des fichiers du projet
COPY . .

# Commande pour lancer l'application (à adapter si nécessaire)
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]
