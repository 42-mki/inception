# Repository 인덱스 업데이트
sudo apt-get update

# 도커 패키지 신뢰성 추가
# f - http의 요청 헤더의 Content-Type을 multipart/form-data로 설정
# s - silent로 진행과정 및 오류 생략
# S - SSL 이용
# L - curl의 결과가 Redirection이더라도, 해당 URL로 작업을 이어감
# 파이프 이후의 apt-key는 다운로드 받은 패키지를 인증된 패키지로 인식 시키기 위해 키 리스트에 패키지를 추가
# (apt는 기본적으로 인증된 패키지들을 키 리스트로 관리)
sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# 도커를 설치할 수 있도록 Repository 추가
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Repository 인덱스 업데이트
sudo apt-get update

# 도커 설치
sudo apt-get install -y docker.io

# 도커 소켓 /var/run/docker.sock 권한 666 설정하여 다른 사용자도 접근할 수 있도록 변경
sudo chmod 666 /var/run/docker.sock

# 도커 컴포즈 설치 (1.29.2 버전)
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 도커 컴포즈 실행 권한 부여
sudo chmod +x /usr/local/bin/docker-compose

# 도커 서비스 재시작 시 컨테이너를 종료하지 않도록 설정
sudo su -c 'printf "{\n\t\"live-restore\": true\n}" > /etc/docker/docker.json'

# 도커 서비스 재시작
sudo systemctl restart docker
