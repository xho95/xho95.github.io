
### \_config.yml 편집하기

GitHub Pages에서는 `_config.yml` 파일에 변경이 가능한 설정과 변경을 할 수 없는 설정을 구분하여 권장하고 있습니다.[^Configuring_GitHub]

아래는 GitHub에서 기본으로 제공하는 설정으로 사용자가 원하는 대로 변경이 가능한 설정입니다.

```
 github: [metadata]
 kramdown:
   input: GFM
   hard_wrap: false
 gems:
   - jekyll-coffeescript
   - jekyll-paginate
```

위에서 `[metadata]` 부분은 사용자의 계정과 관련한 부분이 아닌가 추측됩니다. `kramdown`은 GitHub Pages에서 공식적으로 지원하는 markdown 엔진입니다. 마지막으로 `gems`는 Ruby 패키지 매니저인데, 의존성과 관련한 부분인 것 같습니다.[^Configuring_Question]

`_config.yml` 파일을 변경하는 것은 saltfactory님의 블로그에 설명이 잘 되어 있습니다.[^saltfactory]

아래는 GitHub Pages & Jekyll에서 override 하는 설정으로 변경할 수 없다고 되어 있습니다.

```
 lsi: false
 safe: true
 source: [your repo's top level directory]
 incremental: false
 highlighter: rouge
 gist:
   noscript: false
```

> 다만, Jekyll new로 만든 블로그에는 위의 내용이 없습니다. 확인이 필요한 부분입니다.

위의 설정에서 각 항목들에 대한 간단한 설명은 다음과 같습니다. 항목들에 대한 설명은 Jekyll 사이트에 있습니다.[^Configuration_Jekyll]

* lsi : 관련 포스트글에 대한 인덱스를 생성합니다.
* safe : 사용자 플러그인을 비활성화하고, 심볼릭 링크(symbolic links)를 무시합니다.
* source : Jekyll이 읽을 파일의 위치를 변경합니다.
* incremental : 변경된 포스트만 재빌드하는 옵션입니다.
* highlighter : GitHub에서 자체적으로 설정하는 코드 하이라이터인 것 같습니다. Jekyll 문서에는 따로 설명이 없습니다.
* gist : 이것도 GitHub에서 자체 설정인 것 같습니다.
