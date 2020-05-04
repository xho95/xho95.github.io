---
layout: post
comments: true
title:  "Jekyll: 블로그를 Google Search (구글 검색) 과 Analytics (분석) 에 연동하기"
date:   2020-03-15 11:30:00 +0900
categories: Jekyll Blog Google Search Console Analytics
---

구글 사이트 인증 코드를 Jekyll 블로그에 추가하는 방법입니다.

다음의 참고자료들을 활용하여 진행했습니다.

### Google Search Console 에서 HTML file 인증하기

아마도 파일을 다운 받아서 사이트에 넣으면 되는 것으로 알고 있는데, 워낙 예전에 한 것이라, 좀 더 확인이 필요합니다.

* 구글 검색 등록 : 파일을 다운 받아서 루트 디렉토리에 넣습니다. 그다음에 여러가지 방법이 있는데 `sitemap.txt` 파일로 등록하고 있습니다.

### Google Search Console 에서 HTML tag 인증하기

HTML tag 방식을 사용할 수 있으며, 이 때는 `_config.yml` 파일에서 전체 적용 가능합니다.

적용하는 방법은 참고 자료를 활용하면 됩니다. [^jekyll-issues-3514] [^two-steps]

### Google Search Console 에서 Google Analytics 인증하기

Jekyll 블로그에 Goole Analytics를 달아봅니다.[^google-analytics] 먼저 구글 계정을 만들거나 로그인 합니다.

Google Analytics 도 Search Console 과 마찬가지로 추적 코드는 `<body>` 영역이 아니라 `<head>` 영역에 있어야 합니다.[^setup-for-Jekyll]

설정은 Google Search Console 로 이동한 다음, **Settings > Ownership verification** 메뉴에서 할 수 있습니다.

제대로 설정한 다음에 **Verify** 버튼을 누르면 아래와 같이 성공했다는 메시지를 받습니다.

### Google Search Console 에서 Domain 인증하기

Goole Search Console 에서 DNS record 는 따로 DNS 가 있는 경우 사용하는 것입니다.[^google-domain] 즉, 따로 도메인 이름이 있을 때 쓰는 기능입니다. Jekyll Pages 만 사용할 경우는 해당되지 않는 것 같습니다. 다만 이 부분은 좀 더 확인이 필요합니다.

### Goolge 의 robots.txt 파일 이해하기

여기서는 구글 문서를 통해 **robots.txt** 파일이 무엇인지 어떻게 만드는지 그리고 어떻게 구글에 등록하는지를 알아봅니다. 한 번 익혀두면 네이버 같은 곳에서도 같은 방법으로 적용가능할 것 같습니다.

블로그를 검색 엔진에 등록해서 사용하다보면 **robots.txt** 파일을 설정하라는 얘기를 자주 듣게 됩니다. 평소에 계속 궁금했었는데 마침 구글 **Search Console** 이란 곳에서 **robots.txt** 에 대해 정리가 잘 되어 있는 곳이 있어서 이 참에 정리하도록 합니다.

### robots.txt 사용하기

[Learn about robots.txt files](https://support.google.com/webmasters/answer/6062608?visit_id=1-636234914719756549-1587409561&rd=1)

[Create a robots.txt file](https://support.google.com/webmasters/answer/6062596?hl=en&ref_topic=6061961)

[Test your robots.txt with the robots.txt Tester](https://support.google.com/webmasters/answer/6062598?hl=en&ref_topic=6061961)

[Submit your updated robots.txt to Google](https://support.google.com/webmasters/answer/6078399?hl=en&ref_topic=6061961)

### 알아봐야할 것

* Jekyll 블로그에 category 달기
* Jekyll 블로그에 페이지 기능 넣기
* Goole Tag Manager 인증하기 : Analytics 에서 Tag Manager 생성 가능한 것 같다.

### 참고 자료

[^jekyll-issues-3514]: [Verifying with Google Webmaster](https://github.com/jekyll/jekyll/issues/3514) 글에서는 Google HTML Tag 인증을 위해서 Blog 에 추가해야하는 방식을 설명합니다.

[^two-steps]: [Make your Jekyll Github Pages appear on Google search result (2 steps)](https://victor2code.github.io/blog/2019/07/04/jekyll-github-pages-appear-on-Google.html) 여기서도 HTML Tag 를 사용해서 인증하는 방법을 설명합니다.

[^google-analytics]: [Google Analytics](https://marketingplatform.google.com/about/analytics/) 는 사이트를 분석하게 도와주는 시각화 도구의 하나라 볼 수 있으며, [Google Marketing Platform](https://marketingplatform.google.com/about/) 의 하나입니다.

[^setup-for-Jekyll]: [Google Analytics setup for Jekyll](https://michaelsoolee.com/google-analytics-jekyll/) 에서 설명한 것은 `{% include analytics.html %}` 코드를 `<body>` 에 넣게 되는데, 실제로는 `<head>` 에 넣어야 합니다. 아마도 자료가 조금 예전 것인 듯 합니다.

[^google-domain]: [How to setup google domain for github pages](https://dev.to/trentyang/how-to-setup-google-domain-for-github-pages-1p58) 에서 소개하는 방법은 Domain Name Server 로 Google Domains 를 사용하는 경우에 해당하는 것 같습니다.
