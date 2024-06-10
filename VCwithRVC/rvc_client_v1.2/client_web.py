'''
streamlit run client_web.py --server.sslCertFile host.cert --server.sslKeyFile=host.key --server.port 5000
'''
import streamlit as st
from st_audiorec import st_audiorec
import requests


############################RVC DEMO##########################
st.set_page_config(
    page_title='rvc'
)

# url = 'url'
url = 'http://127.0.0.1:5001'
# url = 'http://192.168.219.119:5000'

# male = 1
# female = 0

st.title("Voice Conversion Demo(mallang service)")
st.markdown("---")
st.write("이 페이지는 말랑의 캐릭터 음성변환 체험 서비스입니다.")
st.write("새 음성을 녹음하거나 음성 파일을 업로드 한 뒤 나이, 성별을 고르고")
st.write("원하는 캐릭터 목소리를 선택한 뒤 목소리 바꾸기 버튼을 눌러주세요")
st.markdown("---")

st.header("음성 녹음 또는 파일 업로드")
st.write("바꾸고 싶은 목소리의 오디오 파일을 업로드해주세요.")
file_upload = st.checkbox("오디오 파일 업로드(mp3, wav)")
if not file_upload :
    wav_audio_data = st_audiorec()
    if wav_audio_data is not None:
        with st.spinner('녹음된 음성을 저장중...'):
            with open('wavs/user.wav', 'wb') as f:
                    f.write(wav_audio_data)
else:
    wav_audio_data = st.file_uploader("Upload audio", type=['wav'])
    if wav_audio_data is not None:
        st.audio(wav_audio_data, format='audio/wav')
        # 오디오 저장
        with st.spinner('업로드된 음성을 저장중...'):
            with open('wavs/user.wav', 'wb') as f:
                f.write(wav_audio_data.read())
st.markdown("---")
st.header("본인 정보 입력 및 캐릭터 선택")
gender_list = ['남자', '여자']
age = 0
selected_gender = st.selectbox("성별을 선택해 주세요", gender_list)
if selected_gender == '남자': 
    gender = 1
    age_list = ['15세 미만', '15세 이상']
    selected_age = st.selectbox("나이를 선택해 주세요", age_list)
    if selected_age == '15세 미만': age = 5
    elif selected_age == '15세 이상': age = 20
    else: st.write('나이 입력이 잘못되었습니다.')
elif selected_gender == '여자': 
    gender = 0
    age_list = ['13세미만', '13세이상']
    selected_age = st.selectbox("나이를 선택해 주세요", age_list)
    if selected_age == '13세 미만': age = 5
    elif selected_age == '13세 이상': age = 20
else:
    st.write("성별 선택이 잘못되었습니다.")

character_list = ['rabbit', 'turtle', 'sombra', 'teemo', 'judy', 'adele']
character_name = st.selectbox("바꾸고 싶은 캐릭터를 입력해주세요", character_list)
st.markdown("---")
def upload_file():
    files = {'wav': open('wavs/user.wav', 'rb')}
    data = {'CharacterId': character_name, 
            'gender': gender, 
            'age': age}
    response = requests.post(f'{url}/upload', files=files, data=data)
    print(response.text)

def download_file():
    response = requests.get(f'{url}/download')
    with open(f'wavs/userTo{character_name}.wav', 'wb') as file:
        file.write(response.content)

if st.button("목소리 바꾸기"):
    if wav_audio_data is not None and gender is not None or character_name is not None or age is not None:
        with st.spinner('음성 변환중...'):
            upload_file()
            download_file()
            st.audio(f'wavs/userTo{character_name}.wav', format='audio/wav')
        st.success('완료')
    else:
        st.write("음성 혹은 선택사항을 다시한번 확인해주세요")

