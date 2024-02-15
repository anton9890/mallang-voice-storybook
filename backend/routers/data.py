from fastapi import APIRouter
from pydantic import BaseModel
from utils.data_control import *

api = APIRouter(prefix='/data')

class Parent_upload_payload(BaseModel):
    id: str
    data: str

@api.post('/parent')
async def TTS(data : Parent_upload_payload):
    # base64 decode 후 wav로 저장
    # 해당 경로를 account json에 parent에 저장

    return 'success'