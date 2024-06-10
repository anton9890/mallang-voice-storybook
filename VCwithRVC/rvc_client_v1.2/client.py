import requests
import time

# 파일 업로드
def upload_file(url, filename, age, gender, characterId):
    files = {'wav': open(filename, 'rb'),'age': age, 'gender': gender, 'CharacterId': characterId}
    data = {'age': age, 'gender': gender, 'CharacterId': characterId}
    response = requests.post(url + '/upload', files=files, data=data)
    # print(response.text)

# 결과 다운로드
def download_file(url):
    response = requests.get(url + '/download')
    if response.status_code == 200:
        with open(f'result/{username}to{characterId}.wav', 'wb') as f:
            f.write(response.content)

# 서버 URL
url = 'http://127.0.0.1:5001'  # 서버 주소와 포트에 맞게 변경
username = "park"
filename = f"D:/src/project_RVC/rvc_client_v1.2/user/{username}/{username}.wav"
gender = 1
age = 28
characterId = "tiger"

if __name__ == '__main__':
    start_time = time.time()

    upload_file(url, filename, age, gender, characterId)
    download_file(url)
    
    end_time = time.time()
    execution_time = end_time - start_time
    print(f"실행 시간: {execution_time} 초")