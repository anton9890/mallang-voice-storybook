from transformers import WhisperFeatureExtractor, WhisperProcessor, WhisperTokenizer, WhisperForConditionalGeneration, Seq2SeqTrainingArguments, Seq2SeqTrainer
import evaluate

from audiodatasets import AudioDatasets
from datacollator import DataCollatorSpeechSeq2SeqWithPadding
from utils import *
# 파인튜닝을 진행하고자 하는 모델의 feature extractor를 로드

feature_extractor = WhisperFeatureExtractor.from_pretrained("openai/whisper-small")
tokenizer = WhisperTokenizer.from_pretrained("openai/whisper-small", language="Korean", task="transcribe")
processor = WhisperProcessor.from_pretrained("openai/whisper-base", language="Korean", task="transcribe")

data_path = "C:\\flyai\\mallang\\stt\\trainer\\data\\"
df = make_df(data_path)
ds = AudioDatasets(df)
split_data = ds.split(test_size=0.2)

# split_data = {
#     "train": ds[:int(len(ds) * 0.8)],
#     "valid": ds[int(len(ds) * 0.1):],
#     "test":  ds[int(len(ds) * 0.1):],
# }

def preprocess(data):
    audio = data["audio"]

    # input audio array로부터 log-Mel spectrogram 변환
    data["input_features"] = feature_extractor(audio["array"], sampling_rate=audio["sampling_rate"]).input_features[0]

    # target text를 label ids로 변환
    data["labels"] = tokenizer(data["transcripts"]).input_ids
    return data

common_voice = split_data.map(preprocess, remove_columns=split_data.column_names["train"], num_proc=None)
# common_voice.push_to_hub("업로드할 허깅페이스 주소 입력")

data_collator = DataCollatorSpeechSeq2SeqWithPadding(processor=processor)

metric = evaluate.load('cer')
model = WhisperForConditionalGeneration.from_pretrained("openai/whisper-small")
model.config.forced_decoder_ids = None
model.config.suppress_tokens = []

training_args = Seq2SeqTrainingArguments(
    output_dir="./save",  # 원하는 리포지토리 이름을 임력한다.
    per_device_train_batch_size=16,
    gradient_accumulation_steps=1,  # 배치 크기가 2배 감소할 때마다 2배씩 증가
    learning_rate=1e-5,
    warmup_steps=500,
    max_steps=4000,  # epoch 대신 설정
    gradient_checkpointing=True,
    fp16=True,
    evaluation_strategy="steps",
    per_device_eval_batch_size=8,
    predict_with_generate=True,
    generation_max_length=225,
    save_steps=1000,
    eval_steps=1000,
    logging_steps=25,
    report_to=["tensorboard"],
    load_best_model_at_end=True,
    metric_for_best_model="cer",  # 한국어의 경우 'wer'보다는 'cer'이 더 적합할 것
    greater_is_better=False,
    push_to_hub=False,
)

trainer = Seq2SeqTrainer(
    args=training_args,
    model=model,
    train_dataset=common_voice["train"],
    eval_dataset=common_voice["valid"],  # or "test"
    data_collator=data_collator,
    compute_metrics=compute_metrics,
    tokenizer=processor.feature_extractor,
)

trainer.train()



# REPO_NAME = "ldhldh/mamba_chat_10kstep" #hf계정명/레포명
# AUTH_TOKEN = "{token}" # write토큰<https://huggingface.co/settings/token>

# kwargs = {
#     "dataset_tags": "사용한 데이터셋의 주소 입력",
#     "dataset": "사용한 데이터셋의 이름 입력",  # a 'pretty' name for the training dataset
#     "dataset_args": "config: ko, split: valid",
#     "language": "ko",
#     "model_name": "모델 이름 입력",  # a 'pretty' name for your model
#     "finetuned_from": "openai/whisper-base",
#     "tasks": "automatic-speech-recognition",
#     "tags": "hf-asr-leaderboard",
# }

# trainer.push_to_hub(**kwargs)
# processor.push_to_hub("repo_name")
# tokenizer.push_to_hub("repo_name")