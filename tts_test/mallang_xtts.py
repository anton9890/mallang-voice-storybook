import torch
import torchaudio
from TTS.tts.configs.xtts_config import XttsConfig
from TTS.tts.models.xtts import Xtts
from huggingface_hub import snapshot_download

#snapshot_download(repo_id="princesslucy/mallang_xtts_v2", local_dir='./model')
config = XttsConfig()
config.load_json("./model/config.json")
model = Xtts.init_from_config(config)
model.load_checkpoint(config, checkpoint_dir="./model")
model.cuda()

def tts(text, temperature=0.7, length_penalty=0.7, repetition_penalty=2.0, speed=1.0, audio="./wavs/input.wav",):
    gpt_cond_latent, speaker_embedding = model.get_conditioning_latents(audio_path=[audio])

    out = model.inference(
    text,
    gpt_cond_latent=gpt_cond_latent,
    speaker_embedding=speaker_embedding,
    temperature=temperature, # Add custom parameters here
    language="ko",
    length_penalty=length_penalty,
    repetition_penalty=repetition_penalty,
    speed=speed,
    enable_text_splitting=False,
    )

    return torchaudio.save("./wavs/output.wav", torch.tensor(out["wav"]).unsqueeze(0), 24000)

#test
tts("이후로 두 친구는 평화롭게 숲속에서 살아갔습니다.", audio="./wavs/jeh.wav")
