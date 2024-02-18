import torch
import torchaudio
from TTS.tts.configs.xtts_config import XttsConfig
from TTS.tts.models.xtts import Xtts
from huggingface_hub import snapshot_download

snapshot_download(repo_id="princesslucy/mallang_xtts_large", local_dir='./tts_test/model')
config = XttsConfig()
config.load_json("./tts_test/model/config.json")
model = Xtts.init_from_config(config)
model.load_checkpoint(config, checkpoint_dir="./tts_test/model")
model.cuda()

def tts(text, temperature=0.3, length_penalty=0.1, repetition_penalty=2.0, speed=1.0, audio="./tts_test/wavs/input.wav",):
    gpt_cond_latent, speaker_embedding = model.get_conditioning_latents(audio_path=[audio])

    out = model.inference(
    text,
    gpt_cond_latent=gpt_cond_latent,
    speaker_embedding=speaker_embedding,
    # temperature=temperature, # Add custom parameters here
    language="ko",
    length_penalty=length_penalty,
    # repetition_penalty=repetition_penalty,
    # speed=speed
    enable_text_splitting=False,
    )

    return torchaudio.save("./tts_test/wavs/output.wav", torch.tensor(out["wav"]).unsqueeze(0), 24000)

#test
tts("그에 대해 고향사람들인 연변 조선족들이 애착을 갖는 것은 자연스럽다. 하지만 윤동주는 조선의 독립운동가로서 조선의 독립과 자유를 갈구했으며 그의 모든 가족들도 중국 공산화 이후 대한민국으로 이주하여 정착했다는 점에서 현대 한국인들이 그를 자국인으로 간주하는 것은 당연하다. 조선의 독립을 위해서 살았던 그의 정신을 계승한다면 같은 한민족이 그를 존경하는 것은 문제가 되진 않을 것이다. 하지만 중국 당국은 윤동주의 명성에 묻어갈 궁리만 하고 있다.")