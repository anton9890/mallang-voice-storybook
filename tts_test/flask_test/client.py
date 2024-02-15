import requests
import base64
import io
import soundfile as sf
import librosa


#보내고자하는 파일을 'rb'(바이너리 리드)방식 열고
def encode_audio(audio):
    audio_content = audio.read()
    return base64.b64encode(audio_content).decode('utf8')

files = open('tts_flask/a1.wav', 'rb')

# 파이썬 딕셔너리 형식으로 file 설정

# request.post방식으로 파일전송.
raw = encode_audio(files)
res = requests.post('http://127.0.0.1:5000/api', json = {"file":raw,"text":"안녕하세요. 반갑습니다."})

bytes = base64.b64decode(res.json()['file']) 
bytesIO = io.BytesIO(bytes)

y, sr = librosa.load(bytesIO, mono=True, duration=30)
sf.write('./' + 'client_output.wav', y, 24000, format='WAV', endian='LITTLE', subtype='PCM_16')
