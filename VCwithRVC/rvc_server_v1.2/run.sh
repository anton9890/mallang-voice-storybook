#!/bin/bash

# 첫 번째 명령어 실행
python3 server.py &

# 두 번째 명령어 실행
streamlit run client_web.py --server.port 5000