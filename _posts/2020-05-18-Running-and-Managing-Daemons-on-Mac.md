---
layout: post
pagination: 
  enabled: true
comments: true
title:  "macOS: Daemon (데몬) 실행하고 관리하기"
date:   2020-05-18 10:00:00 +0900
categories: macOS Daemon launchd launchctl
---

> macOS 에서 데몬 (daemon) 을 실행하는 방법은 Unix 나 Linux 와는 조금 다른 부분이 있습니다. 이 글에서는 macOS 에서 데몬을 실행하고 관리하는 방법을 알아봅니다.

## Daemon (데몬) 실행하고 관리하기

macOS 에서 '데몬 (daemon)'[^daemon] 을 실행하고 관리하는 방식은 Unix 나 Linux 와는 조금 다릅니다. 왜냐면, Apple 에서는 `launchd` 라는 것으로 macOS 의 '부팅 과정시 초기화' 와 '운영체제 서비스 관리' 를 수행하기 때문입니다.[^launchd]

즉, macOS 는 `launchd` 로 '데몬' 과 '에이전트 (agents)' 를 관리합니다. 하지만 `launchd` 를 사용자가 직접 사용하지는 않고, 대신 `launchctl` 라는 명령을 사용하여 데몬이나 '에이전트' 를 '올리거나 (load)' '내립니다 (unload)'.[^apple-launchd]

#### `launchctl`

`launchctl` 은 'IPC'[^IPC] 로 `launchd` 와 통신하는 CLI 프로그램으로 `plist` 파일을 해석하여 `launchd` 가 이해할 수 있는 양식으로 변환하여 전달합니다.

`launchctl` 로 데몬을 올리거나 내릴 수 있고, `launchd` 가 제어하는 작업을 시작하거나 중지할 수 있으며, 환경 설정도 할 수 있습니다.[^launchd]

### Daemon (데몬) 불러오기

앞서 `launchctl` 로 데몬을 '올린다 (load)' 는 표현을 썼는데, 이는 macOS 에서 데몬을 실행할 때 `launchctl load` 라는 명령을 사용하기 때문입니다.[^launchctl-load]

예를 들어, 다음은 `launchctl load` 명령으로 `myservice` 라는 에이전트를 올리는 예입니다.[^launchctl-load-sample]

```zsh
$ launchctl load -w ~/Library/LaunchAgents/myservice.plist
```

#### Apache (아파치) 실행하기

위에 방법으로, macOS 에서 실제로 아파치를 실행하는 방법은 다음과 같습니다.[^apache]

```zsh
$ sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist
```

위에서 `/System/Library/LaunchDaemons` 는 'Apple 이 지원하는 시스템 데몬 (Apple-supplied system daemons)' 이 저장되는 곳입니다.[^apple-launchd]

참고로 아파치는 '시스템 데몬' 이기 때문에 `launchctl load` 앞에 `sudo` 를 붙여서 '관리자 권한' 으로 실행합니다.

### Daemon (데몬) 내리기

`launchctl unload` 명령으로 `myservice` 라는 에이전트를 내리는 예는 다음과 같습니다.

```sh
$ launchctl unload -w ~/Library/LaunchAgents/myservice.plist
```

위에서 `~/Library/LaunchAgents/` 는 에이전트가 있는 위치이며 `myservice.plist` 는 해당 에이전트의 설정 파일입니다.

### 참고 자료

[^daemon]: 컴퓨터 용어로 '데몬 (daemon)' 은 멀티태스킹 OS 에서, 사용자가 직접 제어하지 않고 '백그라운드 프로세스' 로 실행되는 프로그램을 말합니다. (참고로 영어 발음 자체는 '데몬' 보다는 '디먼' 에 좀 더 가깝습니다.) 이에 대한 더 자세한 정보는 위키피디아의 [Daemon (computing)](https://en.wikipedia.org/wiki/Daemon_(computing)) 또는 [데몬 (컴퓨팅)](https://ko.wikipedia.org/wiki/데몬_(컴퓨팅)) 을 보도록 합니다.

[^launchd]: `launchd` 는 BSD-스타일의 `init` 과 `SystemSmarter` 를 대체하기 위해 만든 것으로 Apple 에서 2005년에 발표했습니다. 이에 대한 더 자세한 정보는 위키피디아의 [launchd](https://en.wikipedia.org/wiki/Launchd) 항목을 보도록 합니다.

[^apple-launchd]: 해당 설명에 대한 더 자세한 정보는 Apple 지원 페이지에 있는 [Script management with launchd in Terminal on Mac](https://support.apple.com/guide/terminal/script-management-with-launchd-apdc6c1077b-5d5d-4d35-9c19-60f2397b2369/mac) 를 보도록 합니다. 이에 따르면 macOS 사용자는 `launchd` 로 자기가 만든 '쉘 스크립트 (shell scripts)' 를 실행할 수도 있다고 합니다.

[^IPC]: 'IPC' 는 '프로세스 간의 통신 (Inter-Process Communication)' 을 의미하는 말입니다. 이에 대한 더 자세한 내용은 [Inter-Process Communication (IPC) techniques on Mac OS X](https://www.slideshare.net/Hem_Dutt/ipc-on-mac-osx) 를 보도록 합니다.

[^launchctl-load]: 사실 `launchctl start` 라는 명령도 있지만, `launchctl load` 명령이 macOS 에서 데몬을 실행하는 좀 더 표준적인 방법인 듯 합니다. 이부분은 좀 더 알게되면 정리하도록 하겠습니다.

[^launchctl-load-sample]: 여기서 `myservice` 는 실제로 있는 것이 아니라 그냥 하나의 예시입니다. 해당 내용은 설명을 위해 [How to start a service using Mac OSX's launchctl](https://superuser.com/questions/930389/how-to-start-a-service-using-mac-osxs-launchctl) 에 있는 예제를 참고한 것입니다.

[^apache]: 해당 명령은 모든 설정이 완료됐을 때 실행하는 것입니다. macOS 에서 아파치를 설정하고 실행하는 전체 과정은 [Apache : macOS 에서 아파치 웹서버 실행하기]({% post_url 2016-10-02-Apache-WebServer %}) 를 보도록 합니다.
