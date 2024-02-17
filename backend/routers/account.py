from fastapi import APIRouter
from typing import Optional
from fastapi import FastAPI
from pydantic import BaseModel
from utils.data_control import *

class Login_payload(BaseModel):
    id: str
    password: str

class Register_payload(BaseModel):
    id: str
    password: str
    name: str
    
class Data_add_payload(BaseModel):
    id: str
    name: str
    age: Optional[int] = None
    gender: Optional[str] = None
    like: Optional[list] = None
    history: Optional[list] = None
    parent: Optional[str] = None

account = APIRouter(prefix='/account')

@account.post('/login')
async def login(data: Login_payload):
    if login_check(data.id, data.password):
        return "success"
    return "fail"

@account.post('/register')
async def register(data: Register_payload):
    if add_account(data.id, data.password, data.name):
        return "success"
    return "fail"

@account.post('/update')
async def update(data: Data_add_payload):
    if add_data(data.id, data.name, data.age, data.gender, data.like):
        return "success"
    return "fail"

@account.get('/get/{user}')
async def get_data(user):
    data = get_json()
    if user in data:
        return data[user]['info']
    return "fail"