import librosa # apt-get install ffmpeg  : linux에서 필요
from fastapi import FastAPI, UploadFile, File, Form
from fastapi.responses import FileResponse
import asyncio
from pydantic import BaseModel

import soundfile as sf

from mallang_xtts import *


def down_sample(y, sr, resample_sr):
    resample = librosa.resample(y, orig_sr=sr, target_sr=resample_sr)
    sf.write('./tts_test/wavs/input.wav', resample, resample_sr, format='WAV', endian='LITTLE', subtype='PCM_16')
    return resample

app = FastAPI()
print("start app")

class TTSItem(BaseModel):
    text: str = Form(...)
    wav: UploadFile = File(...)

@app.post('/tts') 
async def api(text: str = Form(...), wav: UploadFile = File(...)):
    wav_content = await wav.read()
    text = text
    with open("./wavs/input.wav", "wb") as file:
        file.write(wav_content)
    loop = asyncio.get_event_loop()
    await loop.run_in_executor(None, tts, text)

    return FileResponse("./wavs/output.wav", filename="output.wav")