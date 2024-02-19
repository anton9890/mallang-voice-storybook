import librosa # apt-get install ffmpeg  : linux에서 필요
from flask import Flask
from flask import request, send_file
import base64
import io
import soundfile as sf
import base64
import torch
import torchaudio
from TTS.api import TTS
from TTS.tts.configs.xtts_config import XttsConfig
from TTS.tts.models.xtts import Xtts

print("Loading model...")
config = XttsConfig()
config.load_json("./tts/config.json")
model = Xtts.init_from_config(config)
model.load_checkpoint(config, checkpoint_dir="./tts/")
#use_deepspeed=True
model.cuda()

def encode_audio(audio):
    audio_content = audio.read()
    return base64.b64encode(audio_content).decode('utf8')

def down_sample(y, sr, resample_sr):
    resample = librosa.resample(y, orig_sr=sr, target_sr=resample_sr)
    sf.write('./' + 'temp.wav', resample, resample_sr, format='WAV', endian='LITTLE', subtype='PCM_16')
    return resample


app = Flask(__name__)
print("start app")

@app.route('/tts', methods=['post']) 
def api():

    wav = request.files['wav']
    text = request.form['text']
    y, sr = librosa.load(wav, mono=True, duration=30)

    y = down_sample(y, sr, 22050)
    gpt_cond_latent, speaker_embedding = model.get_conditioning_latents(audio_path=[f"temp.wav"])
    out = model.inference(
        text,
        language = "ko",
        gpt_cond_latent = gpt_cond_latent,
        speaker_embedding = speaker_embedding,
        temperature=0.7, # Add custom parameters here
        top_p = 0.8,
        top_k = 50,
        speed = 1.0,
        repetition_penalty = 2.2,
        length_penalty = 1.1,
    )
    torchaudio.save("output.wav", torch.tensor(out["wav"]).unsqueeze(0), 24000)

    return send_file("output.wav", as_attachment=True)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=False)