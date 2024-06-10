import numpy as np
import librosa

def calculate_average_octave(audio_file):
    # 오디오 파일 로드
    audio, sr = librosa.load(audio_file)

    # 스펙트럼 분석
    spectrum = np.abs(librosa.stft(audio))

    # 옥타브 범위 설정 (20Hz부터 20kHz)
    min_freq = librosa.note_to_hz('C0')
    max_freq = librosa.note_to_hz('C8')

    # 주파수 배열 생성
    freqs = librosa.fft_frequencies(sr=sr)

    # 옥타브 인덱스 계산
    min_bin = np.abs(freqs - min_freq).argmin()
    max_bin = np.abs(freqs - max_freq).argmin()

    # 옥타브 스펙트럼 추출
    octave_spectrum = spectrum[min_bin:max_bin+1, :]

    # 옥타브 스펙트럼의 평균 계산
    average_octave = np.mean(octave_spectrum)

    return average_octave

# 사용 예시
audio_file_path = 'rabbit.wav'
average_octave = calculate_average_octave(audio_file_path)
print("평균 옥타브:", average_octave)
