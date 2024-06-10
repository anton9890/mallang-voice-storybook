from flask import Flask, request, send_file
from scipy.io import wavfile
from VoiceConversion import getParameter, get_vc, vc_single, get_tgt_sr #inference module

app = Flask(__name__)

i = 0
wavpath = ""

def inference(characterId,userAge,userGender,wavpath):
    f0up_key,input_path,index_path,f0method,model_path,index_rate,filter_radius,resample_sr,rms_mix_rate,protect = getParameter(characterId,userAge,userGender,wavpath)
    #get model by model path
    get_vc(model_path)
    #inference
    opt_wav=vc_single(0,input_path,f0up_key,None,f0method,index_path,index_rate,filter_radius,resample_sr,rms_mix_rate,protect)
    wavfile.write(f"result/{wavpath}",get_tgt_sr(),opt_wav)


@app.route('/upload', methods=['POST'])
def upload_file():
    global wavpath, i
    wav = request.files['wav']
    userAge = int(request.form['age'])
    if int(request.form['gender']) == 0 or 1 :
        userGender = int(request.form['gender'])
    elif request.form['gender'] == '여성' or '여자' or 'female' or 'f' or 'womman' or 'w' :
        userGender = 0
    elif request.form['gender'] == '남성' or '남자' or 'male' or 'm' or 'man' :
        userGender = 1
    else:
        userGender = 0
        print("사용자 성별이 잘못되어 여자로 설정하였습니다")

    characterId = request.form['CharacterId']
    wavpath = f"{i}.wav"
    input_path = f"input/{wavpath}"
    wav.save(input_path)
    # seperateVoice(wavpath)
    #voice conversion inference
    inference(characterId,userAge,userGender,wavpath)
    return 'File uploaded successfully!'


@app.route('/download', methods=['GET'])
def download_file():#send result to client
    global wavpath, i
    try:
        with open(f'result/{wavpath}', "rb") as infer_wav:
            i = i+1
            return send_file(f'result/{wavpath}', as_attachment=True)
    except FileNotFoundError:
        print("no file exist")
        return -1

if __name__ == '__main__':
    # app.run(host='127.0.0.1', port=5001, debug=True)
    app.run(host='0.0.0.0', port=5001, debug=True)