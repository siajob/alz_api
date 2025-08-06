import numpy as np
import cv2

def preprocess_image(image_array):
    image = np.array(image_array, dtype=np.float32)
    image = cv2.resize(image, (128, 128))  # ⚠️ adapte à ton modèle
    image = image / 255.0
    return image.reshape(1, 128, 128, 3)  # format (batch, height, width, channels)
