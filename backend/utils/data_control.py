import os.path
import json

def update(data):
    file = 'account.json' 

    if not os.path.isfile(file):
        json_data = {
            "aaaa" : {
                "pw" : "bbbb",
                "info" : {
                    "name" : "김차돌",
                    "age" : None,
                    "gender" : None,
                    "like" : None,
                    "history" : None,
                    "parent" : None
                }
            }
        }
        with open(file, 'w', encoding='utf-8') as f:
            json.dump(json_data, f, indent="\t", ensure_ascii=False)
    
    with open(file, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent="\t", ensure_ascii=False)
    return 0

def get_json():
    file = 'account.json'

    if not os.path.isfile(file):
        json_data = {
            "aaaa" : {
                "pw" : "bbbb",
                "info" : {
                    "name" : "김차돌",
                    "age" : None,
                    "gender" : None,
                    "like" : None,
                    "history" : None,
                    "parent" : None
                }
            }
        }
        with open(file, 'w', encoding='utf-8') as f:
            json.dump(json_data, f, indent="\t", ensure_ascii=False)
    else:
        with open(file, 'r', encoding='utf-8') as f:
            json_data = json.load(f)
    return json_data

def login_check(id, password): # 로그인 검증
    data = get_json()
    
    if id in data:
        if data[id]["pw"] == password:
            return True
    
    return False

def add_account(id, password, name): #  계정 추가
    data = get_json()

    if id in data:
        return False
    data[id]={
            "pw" : password,
            "info" : {
                "name" : name,
                "age" : None,
                "gender" : None,
                "like" : None,
                "history" : None,
                "parent" : None
            }
    }
    update(data)
    return True

def add_data(id, name, age, gender, like, history, parent):
    data = get_json()

    if not id in data:
        return False
    data[id]={
            "pw" : data[id]["pw"],
            "info" : {
                "name" : name,
                "age" : age,
                "gender" : gender,
                "like" : like,
                "history" : history,
                "parent" : parent
            }
    }
    update(data)
    return True

