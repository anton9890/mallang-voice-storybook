import json
import glob
import pandas as pd

# def preprocess(data):
#     audio = data["audio"]

#     # input audio array로부터 log-Mel spectrogram 변환
#     data["input_features"] = feature_extractor(audio["array"], sampling_rate=audio["sampling_rate"]).input_features[0]

#     # target text를 label ids로 변환
#     data["labels"] = tokenizer(data["transcripts"]).input_ids
#     return data

def compute_metrics(pred, metric, tokenizer):
    pred_ids = pred.predictions
    label_ids = pred.label_ids

    # pad_token을 -100으로 치환
    label_ids[label_ids == -100] = tokenizer.pad_token_id

    # metrics 계산 시 special token들을 빼고 계산하도록 설정
    pred_str = tokenizer.batch_decode(pred_ids, skip_special_tokens=True)
    label_str = tokenizer.batch_decode(label_ids, skip_special_tokens=True)

    cer = 100 * metric.compute(predictions=pred_str, references=label_str)

    return {"cer": cer}

def make_df(data_path):

    data_file = data_path + "*.json"
    json_files = glob.glob(data_file)

    df_list = []
    for file in json_files:
        # 각 파일을 json으로 읽어 들입니다.
        with open(file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # 'sentence'와 'audio'의 'path'를 추출하여 데이터프레임으로 만들고, 이를 리스트에 저장합니다.
        df = pd.DataFrame({'sentence': [data['sentence']], 'path': [data_path + data['audio']['path']]})
        df_list.append(df)

    # 모든 데이터프레임을 하나로 합칩니다.
    merged_df = pd.concat(df_list, ignore_index=True)
    return merged_df
    


# data_path = "C:\\flyai\\mallang\\stt\\trainer\\data\\"

# data = make_df(data_path)
# print(data)