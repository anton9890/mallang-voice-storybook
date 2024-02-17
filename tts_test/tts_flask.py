import librosa
from flask import Flask
from flask import request
import numpy as np
import json
import base64
import io
import soundfile as sf
import base64
from TTS.api import TTS
from mallang_xtts import *

def encode_audio(audio):
    audio_content = audio.read()
    return base64.b64encode(audio_content)

tts = TTS("princesslucy/mallang_xtts", gpu=True)

def down_sample(y, sr, resample_sr):
    resample = librosa.resample(y, orig_sr=sr, target_sr=resample_sr)
    sf.write('./tts_test/wavs/input.wav', resample, resample_sr, format='WAV', endian='LITTLE', subtype='PCM_16')
    return resample

app = Flask(__name__)
print("start app")

@app.route('/api', methods=['post']) 
def api():
    d = request.get_json()
    file = d['file']
    text = d['text']
    bytes = base64.b64decode(file) 
    bytesIO = io.BytesIO(bytes)
    y, sr = librosa.load(bytesIO, mono=True, duration=30)

    y = down_sample(y, sr, 24000)

    tts(text)

    return {"file":encode_audio(open("output.wav", "rb")).decode('utf8')}

if __name__ == "__main__":
    app.run(host='127.0.0.1', port=5000, debug=False)