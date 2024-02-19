import requests

file = './tts_test/wavs/input.wav'
raw = open(file, 'rb')
files = {'wav': raw}
data = {'text': '죽는 날까지 하늘을 우러러 한 점 부끄럼이 없기를,잎새에 이는 바람에도 나는 괴로워했다.'}
res = requests.post('http://127.0.0.1:5000/tts', files=files, data = data)
with open(f'./tts_test/client_wavs/output.wav', 'wb') as file:
    file.write(res.content)