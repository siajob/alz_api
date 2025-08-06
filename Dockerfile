# Utilise une image Python officielle avec version 3.10
FROM python:3.10-slim

# Définit le répertoire de travail
WORKDIR /app

# Copie les fichiers requirements.txt et runtime.txt
COPY requirements.txt .

# Installe les dépendances avec pip
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copie tout le contenu du projet dans le conteneur
COPY . .

# Expose le port utilisé par l'application Flask
EXPOSE 8000

# Commande pour lancer ton API (ajuste selon ton app)
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:8000"]
