import os
from fastapi import APIRouter
from pydantic import BaseModel
from utils.data_control import *


api = APIRouter(prefix='/api')

class TTS_payload(BaseModel):
    id: str
    text: str

@api.post('/tts')
async def TTS(data : TTS_payload):
    json_data = get_json()

    if not data.id in json_data:
        return 'fail'

    path = "/parent"
    file = "a1.wav"
    if json_data[data.id]['info']['parent'] != None:
        if os.path.isfile(json_data[data.id]['info']['parent']):
            file = json_data[data.id]['info']['parent']

    

    return 'success'