import soundfile as sf
from infer_uvr5 import _audio_pre_
import numpy as np

audio_path = 'user.wav'
mixwav_mc, sr = sf.read(audio_path)
mixwav_sc = mixwav_mc[:,1]
print(mixwav_mc.shape)
max_value = np.max(np.abs(mixwav_sc))
normalized_data = mixwav_sc / max_value
print(normalized_data.shape)
sf.write(audio_path, normalized_data, sr)
sf.write(audio_path, mixwav_sc, sr)
model_path = "HP5_only_main_vocal.pth"
pre_fun = _audio_pre_(model_path=model_path, device="cuda", is_half=True, agg=10)
save_path = "D:/src/sktflyai/project/rvc_server_v1.1/"
pre_fun._path_audio_(audio_path, save_path, save_path, format = 'wav')
    
