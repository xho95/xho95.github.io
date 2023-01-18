---
layout: post
pagination:
  enabled: true
comments: true
title: "Swift: Perfect Assistant 로 AWS 에 서버 배포하기"
date: 2017-03-21 02:00:00 +0900
categories: Linux Swift Perfect Package Server
redirect_from: "/linux/swift/perfect/package/server/2017/03/20/Deploying-with-Perfect-Assistant.html"
---

Ray Wenderlich 사이트에서 Server Side Swift with Perfect 시리즈 동영상으로 [Perfect Assistant 소개하기 (Introduction to Perfect Assistant)](https://videos.raywenderlich.com/screencasts/server-side-swift-with-perfect-introduction-to-perfect-assistant) 라는 영상과 [Perfect Assistant 로 배포하기 (Deploying with Perfect Assistant)](https://videos.raywenderlich.com/screencasts/server-side-swift-with-perfect-deploying-with-perfect-assistant) 라는 영상을 추가했습니다.

이 중에서 이번에는 [Perfect Assistant 로 배포하기 (Deploying with Perfect Assistant)](https://videos.raywenderlich.com/screencasts/server-side-swift-with-perfect-deploying-with-perfect-assistant) 에 대한 내용을 정리합니다. [^introduction]

### 들어가며

[Perfect Assistant](https://perfect.org/en/assistant/) 는 명령줄로 수행하는 작업들을 명령줄을 사용하지 않고도 할 수 있도록 도와주는 도구입니다. 프로젝트를 생성하고 의존성 파일을 작성하는 등의 동작을 버튼 클릭으로 간단하게 수행해 줍니다. 말 그대로 도우미 역할을 수행합니다.

설치하고 나서 실행하면 아래와 같은 화면이 나타납니다. [^install]

![Perfect Assistant](/assets/Perfect/perfect-assistant-aws.jpeg)

### AWS 설정하기

위의 화면을 보면 도커 (Docker), 아마존 AWS 등이 연동되는 것을 볼 수 있습니다. AWS 를 연동하기 위해서는 당연한 얘기지만 일단 AWS 에 계정이 있어야 합니다.

#### AWS CLI 설치하기

Perfect Assistant 로 AWS 에 접속하려면 `awscli` [^aws-cli] 를 설치해야 합니다. [^assistant-aws] 맥에서는 다음과 같이 터미널에서 Homebrew 를 사용해서 설치할 수 있습니다.

```
$ brew install awscli
```

각 운영 체제 별로 설치하는 방법 등에 대한 정보는 [AWS 명령줄 인터페이스](https://aws.amazon.com/ko/cli/) 를 참고하도록 합니다.

#### 사용자 만들기

이제 서버에 배포하기 위해 일종의 사이트 관리자 계정을 만듭니다. **Services > Security, Identity & Compliance > IAM** [^iam] 메뉴를 선택하고 **Users > Add user** 를 선택해서 사용자를 만듭니다. 사용자 이름은 perfect 로 하고 접근 권한은 Programmatic access 를 체크한 다음 Next: Permissions 를 누릅니다.

이제 사용자 그룹도 만듭니다. 여기서 EC2 에 대한 접근 권한을 부여합니다. **Create group** 을 선택한 다음 Group name 은 ec2-full-access 로 하고 권한은 검색창에 EC2 를 입력해서 맨 위의 AmazonEC2FullAccess 를 선택합니다. 맨 밑의 **Create group** 을 눌러서 그룹을 생성합니다.

**Next: Review** 를 누른 후 다음 화면에서 **Create user** 를 누릅니다.

마지막 단계에서 Access Key 와 Secret Access Key 를 만듭니다. 이 값들을 복사해서 안전한 곳에 옮겨 둡니다. 이 값들은 `aws configure` 에서 사용합니다.

#### 터미널에서 AWS 설정하기

다시 터미널로 돌아와서 AWS CLI 를 사용하여 AWS 에 대한 환경 설정을 해줍니다.

아래와 같이 `aws configure` 명령을 실행하고 앞서 저장한 Access Key 와 Secret Access Key 를 등록합니다.

'Default region name' 은 Seoul 리전을 선택할 경우 `ap-northeast-2` 라고 입력하고, 'Default output format' 은 json 으로 입력합니다.

```
$ aws configure

AWS Access Key ID [None]:
AWS Secret Access Key [None]:
Default region name [None]:  ap-northeast-2
Default output format [None]: json
```

위에서 Default region name 은 주의해서 입력해야 합니다. 입력 값은 AWS 홈페이지의 [리전 및 가용 영역](http://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/using-regions-availability-zones.html) [^aws-regions] 글을 참고해서 입력하면 됩니다.  

설정이 제대로 됐는지 테스트하려면 다음과 같은 명령을 입력합니다. [^reservations]

```
$ aws ec2 describe-instances

{
    "Reservations": []
}
```

#### SSH 공개키 만들고 등록하기

이제 사용중인 컴퓨터에서 AWS 에 로그인할 때 본인임을 인증하기 위한 SSH 키를 만듭니다.  아래와 같은 명령을 사용해서 키를 만들 수 있습니다. [^xho95-ssh]

```
$ ssh-keygen -t rsa -C "perfect-key" -f ~/.ssh/perfect-key

Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

생성한 SSH 키를 다음과 같은 AWS CLI 명령을 사용하여 서버에 등록합니다.

```
$ aws ec2 import-key-pair --key-name "perfect-key" --public-key-material file://$HOME/.ssh/perfect-key.pub

{
    "KeyName": "perfect-key",
    "KeyFingerprint": "...:..."
}
```

위에서 SSH 키는 앞서 'Default region name' 로 지정한 리전으로 업로드됩니다. 따라서 나중에 perfect 를 배포할 때도 지정된 리전을 선택해야 배포할 수 있습니다.

#### Security Group 설정하기

이제 Security Group 을 만듭니다. Security Group 은 서버에 접속하는 클라이언트에 대한 권한 등을 입력하는 곳입니다. **Services > Compute > EC2** 메뉴를 선택합니다. 왼쪽의 메뉴에서 NETWORK & SECURITY 밑에 있는 **Security Groups** 를 선택합니다.

이제 메인 화면에서 **Create Security Group** 버튼을 눌러 새 그룹을 만듭니다. 'Security group name' 은 hello-perfect 로 지정하고 'Description' 은 8080 and SSH 로 적어줍니다.

**Add Rule** 버튼을 눌러서 포트는 8080 으로 Source 는 Anywhere 를 선택합니다. 한번더 눌러서 포트는 22 로 Source 는 Anywhere 로 선택합니다. 여기서 포트 22 는 SSH 를 위한 포트입니다.

이제 **Create** 를 눌러 그룹을 생성합니다.

이로써 AWS 설정은 마쳤습니다. 이제 Perfect Asssistant 를 설정할 차례입니다.

### Perfect Assistant 설정하기

#### EC2 Credentials 설정하기

Perfect Asssistant 를 실행한 후 맨 위의 그림과 같은 Welcome 화면에서 **Configure EC2 Credentials...** 를 누릅니다. 그러면 아래와 같은 대화 상자가 나타납니다.

![Perfect EC2 Credentials](/assets/Perfect/perfect-ec2-credentials.jpeg)

대화 상자에서 **Create** 를 눌러서 새로 등록합니다. 'CREDENTIALS NAME'은 perfect 로 지정하고 앞서 저장한 Access Key 와 Secret Access Key 를 넣어줍니다. 'DEFAULT REGION' 은 앞서 지정한 'Default region name' 와 같은 값을 선택합니다. 여기서는 `ap-northeast-2` 를 선택합니다.

#### 프로젝트 불러오기

이제 배포할 프로그램을 불러올 차례입니다. 이전에 만든 hello-perfect 를 사용합니다.

Perfect Asssistant 의 Welcome 화면에서 **Import Existing Project** 를 선택합니다. Integrate Linux builds with Xcode 는 리눅스용 실행 파일도 만드는 옵션같은데 체크해도 되고 안해도 되는 것 같습니다.

**Save** 버튼을 누릅니다. 그러면 콘솔 창에 저장됐다는 메시지가 뜹니다.

![Perfect Assistant Build](/assets/Perfect/perfect-assistant-build.jpeg)

#### 로컬에서 테스트하기

이 부분은 건너뛰어도 되긴 하지만 잘 작동하는지 확인하기 위해 실습을 해 봅니다. Projects 에서 불러온 프로젝트를 선택하고 **BUILD > Local** 을 눌러서 빌드합니다.

```
Starting macOS build of /.../Hello-Perfect
Success.
```

위와 같이 빌드가 끝나면 **RUN > Local Exe** 를 눌러서 로컬에서 테스트를 할 수 있습니다. 서버가 실행되면 브라우저에서 `localhost:8080` 으로 접속해서 결과를 확인할 수 있습니다.

![Perfect Assistant Local Test](/assets/Perfect/perfect-assistant-local-test.jpeg)

### AWS 에 배포하기

이제 서버쪽 환경 설정도 마쳤고 프로젝트도 동작하는 것을 확인했으니 실제로 AWS 에 배포를 해봅니다. 일단 배포 환경을 설정하고 이어서 설정된 환경으로 배포하도록 합니다.

#### 배포 환경 설정하기

Perfect Assistant 의 Welcome 화면에서 **BUILD > Deploy** 메뉴를 선택합니다.

![Perfect Assistant Deploy](/assets/Perfect/perfect-assistant-deploy.jpeg)

그러면 위와 같은 대화 상자가 나타나는데 아직 배포 설정이 갖춰진 것이 없으므로 **Create New...** 버튼을 눌러서 새로 배포 환경을 등록합니다. [^deploy-button] 이후의 화면에서는 **AWS** 를 선택하고 **Next** 를 누릅니다. 그러면 아래와 같은 대화 상자가 나타납니다.

![Perfect AWS Deployment](/assets/Perfect/perfect-aws-deployment.jpeg)

여기에서 'CONFIGURATION NAME' 은 perfect 로 지정합니다. 실제로는 아무렇게 넣어도 상관없는 것 같습니다.

'EC2 CREDENTIALS' 은 화살표를 눌러서 위에서 만든 perfect 를 선택해 줍니다.

'SSH KEY' 는 **Choose...** 버튼을 눌러서 perfect-key 가 저장된 위치를 찾은 후 private 키를 선택해 줍니다.

'AVAILABLE INSTANCES' 에서는 **Add..** 를 눌러 줍니다. 그러면 새로운 대화 상자가 나타나는데 아래 그림을 참고해서 지정해 줍니다. [^ap-northeast-2]  

![Perfect Available Instance](/assets/Perfect/perfect-available-instance.jpeg)

'SECURITY GROUPS' 에서 hello-perfect 가 나타나야 정상입니다. 이것은 AWS 에서 설정한 Security Group 이 나타나는 곳입니다.

위와 같이 설정이 됐으면 **Launch** 를 눌러 끕니다.

조금 기다리면 콘솔 화면에 Success 가 나타납니다. 'AVAILABLE INSTANCES' 옆에 있는 **Reload** 를 여러번 눌러주면 유효한 EC2 인스턴스가 나타나며 이를 선택해서 Save 를 눌러줍니다.

#### 실제 배포하기

지금까지는 배포 환경을 만들고 등록해 준 것입니다. 이제 Perfect Assistant 의 Welcome 화면에서 다시 한번 **BUILD > Deploy** 메뉴를 선택합니다.

이제 대화 상자에서 Deploy 버튼을 누릅니다. 그러면 실제 배포 작업이 이루어집니다.

그러면 콘솔에 배포되고 있는 상황이 나타납니다. 이 과정은 생각보다 시간이 걸리는데 인내심을 갖고 기다리다보면 Success 가 뜨는데 그러면 배포가 된 것입니다. [^deploy-process]

이제 EC2 Dashboard 에서 실행중인 인스턴스의 **Public DNS** 를 사용해서 접속해보면 아래와 같이  AWS 에서 서버가 동작하는 것을 확인할 수 있습니다.

![Perfect AWS Success](/assets/Perfect/perfect-aws-success.jpeg)

축하합니다! 이제 Perfect Assistant 를 사용해서 자신의 서버를 AWS 에 배포할 수 있게 되었습니다.

### 서버에 SSH 로 접속하기

필요하다면 SSH 키를 사용하여 AWS 에 직접 접속할 수 있습니다. 서버 환경을 설정하거나 직접 배포하기를 원하는 경우에 사용할 수 있습니다.

```
$ ssh -i ~/.ssh/perfect-key ubuntu@ec2-13-124-50-118.ap-northeast-2.compute.amazonaws.com
```

위와 같이 하면 콘솔 프롬프터가 AWS 에 있는 ubuntu 로 바뀝니다. 아래와 같이 명령을 입력하면 AWS 에 배포된 내용들을 볼 수 있습니다.

```
$ cd /
$ ls

bin             lib               proc   swift-3.0.2-RELEASE-ubuntu16.04
boot            lib64             root   sys
dev             lost+found        run    tmp
etc             media             sbin   usr
home            mnt               snap   var
initrd.img      opt               srv    vmlinuz
initrd.img.old  perfect-deployed  swift  vmlinuz.old
```

AWS 에서 로그아웃하려면 exit 명령을 사용합니다.

```
$ exit

logout
Connection to ec2-13-124-50-118.ap-northeast-2.compute.amazonaws.com closed.
```

이 부분은 영상에서 덤으로 소개한 부분으로 당장은 꼭 알 필요 없지만 리눅스에 익숙한 분이라면 어렵지 않게 사용할 수 있을 것입니다.

### 원문 자료

* [Server Side Swift with Perfect: Deploying with Perfect Assistant](https://videos.raywenderlich.com/screencasts/server-side-swift-with-perfect-deploying-with-perfect-assistant)

### 관련 자료

* [Swift: 리눅스에서 Perfect 프레임웍으로 서버 개발하기 (Part 1)]({% post_url 2017-03-07-Swift-with-Perfect-Part-1 %})
* [Swift: 리눅스에서 Perfect 프레임웍으로 서버 개발하기 (Part 2)]({% post_url 2017-03-10-Swift-with-Perfect-Part-2 %})

### 참고 자료

[^introduction]: 여기서는 [Perfect Assistant 소개하기](https://videos.raywenderlich.com/screencasts/server-side-swift-with-perfect-introduction-to-perfect-assistant) 영상은 따로 정리하지 않습니다. 설치 및  사용 방법은 동영상을 보고 따라하면 되고 실습도 이전에 만든 hello-perfect 를 Assistant 로 다시 만들어 보는 것이 전부입니다. Perfect Assistant 자체에 대해서는 나중에 따로 정리할 예정입니다.

[^install]: 다운로드는 [The Perfect Assistant](https://perfect.org/en/assistant/) 에서 할 수 있습니다. 아직은 macOS 에만 설치가 가능한 것 같습니다. 따라서 이번 실습은 리눅스가 아닌 맥에서 수행하도록 합니다.

[^aws-cli]: `awscli` 에 대해서는 [DevOps를 위한 AWS CLI 활용팁](https://aws.amazon.com/ko/blogs/korea/tips-aws-cli/) 이라는 글을 읽어볼 만 합니다.

[^assistant-aws]: AWS 에 배포하기 위해 `awscli` 를 설치해야 하는 것은 아니지만 `awscli` 를 설치해야 Perfect Assistant 에서 AWS 를 인식해서 버튼이 활성화되는 것 같습니다.

[^iam]: IAM 은 Identity and Access Management 의 약자로 사용자를 등록하고 접근 권한을 지정하는 곳입니다.

[^aws-regions]: AWS 의 [리전 및 가용 영역](http://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/using-regions-availability-zones.html) 글에서 **사용 가능한 리전** 부분을 보면 각 리전을 선택하기 위한 코드가 표로 정리되어 있습니다. **아시아 태평양(서울)** 을 선택하려면 `ap-northeast-2` 를 입력하면 됨을 알 수 있습니다.

[^reservations]: 실습을 하고나서 인스턴스를 삭제하면 아무것도 나타나지 않는 것 같습니다. 이부분은 저도 AWS 에 대해서 모르는 것이 많아서 정확한 내용은 아직 잘 모르겠습니다.

[^xho95-ssh]: 맥에서 SSH 키를 생성하고 사용하는 방법에 대해서는 [macOS: 맥에서 SSH 키 생성하고 사용하기]({% post_url 2017-02-22-Using-SSH-on-Mac %}) 라는 글을 참고하도록 합니다.

[^deploy-button]: 여기서는 Deploy 버튼이 의미가 없고 실제로는 나중에 환경 설정이 끝난 후에 Deploy 버튼을 사용하게 됩니다. 이 부분은 UI 가 조금 헷갈리게 설계된 것 같습니다.

[^ap-northeast-2]: 이를 위해서 이전에 region 을 잘 맞춰뒀어야 합니다. 앞서 Default region name 으로 설정한 곳과 같은 곳을 선택해야하며 같은 곳에 SSH 키를 업로드 해야 합니다. 저의 경우 region 은 Seoul 에 맞추기 위해 모두 `ap-northeast-2` 로 지정했습니다.

[^deploy-process]: 이 과정에서 콘솔을 보면 뭔가 내부적으로는 도커를 사용하고 있는 것 같습니다. 저의 경우 AWS 로 배포하기 전에 도커가 설치되어 있는 환경이었는데, 만약 도커가 설치되어 있지 않았다면 어떻게 진행되는지는 잘 모르겠습니다.
