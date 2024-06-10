# syntax=docker/dockerfile:1

FROM nvidia/cuda:12.3.2-base-ubuntu22.04

# NVIDIA 런타임 설정
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

WORKDIR /app

RUN apt-get update && apt-get install -y python3 python3-pip ffmpeg
COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY . .
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000

CMD ["/run.sh"]