from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
import os
import gdown
from utils import preprocess_image

app = Flask(__name__)

MODEL_PATH = "alz_model.tflite"
MODEL_URL = "https://drive.google.com/uc?id=1BB93Q1B3wGGuxs5_I5eRDV4qSZxC14gi"  # ⚠️ à adapter

# Télécharger si pas déjà présent
if not os.path.exists(MODEL_PATH):
    print("Téléchargement du modèle depuis Google Drive...")
    gdown.download(MODEL_URL, MODEL_PATH, quiet=False)

# Charger le modèle TFLite
interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    image = np.array(data['image'], dtype=np.float32)
    image = preprocess_image(image)  # adapter à ton modèle

    interpreter.set_tensor(input_details[0]['index'], image)
    interpreter.invoke()
    output_data = interpreter.get_tensor(output_details[0]['index'])
    prediction = output_data.tolist()[0]

    return jsonify({"prediction": prediction})
