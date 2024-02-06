import whisper
import speech_recognition as sr
import torch
import numpy as np
import time

def listen(audio_model):
        print("무슨 말이라도? : ")
        with sr.Microphone(sample_rate=16000) as source:
            audio = r.listen(source)
            audio_data = torch.from_numpy(np.frombuffer(audio.get_raw_data(), np.int16).flatten().astype(np.float32) / 32768.0).to("cuda")
            #record inference time
            start = time.time()
            text = audio_model.transcribe(audio_data, fp16=False)["text"]
            end = time.time()
            inference_time = end - start
            return text, inference_time


r = sr.Recognizer()
r.energy_threshold = 200
r.pause_threshold = 0.5
r.dynamic_energy_threshold = False
audio_model = whisper.load_model("large-v3").to("cuda")

while True :
    my_speech, inference_time = listen(audio_model)
    if my_speech == "종료" :
        break
    else :
        print('stt: ', my_speech) #어둔 방은 우주로 통하고 하늘에선가 소리처럼 바람이 불어온다.
        print("inference time : ", inference_time)