이 글은 분산 정리해서 지우도록 합니다. 

### 목차

1. 왜 Jekyll 관련 글을 다시 작성하는가? - 세가지 이유
    1. GitHub 에 중심을 두는 것이 중요
    	* 주위 분들에게 설명하면서 Jekyll 을 설명하려는 것 보다 GitHub Pages 에 블로그를 만드는 순서로 자연스럽게 설명하는 것이 좋다는 생각을 하게 됨
    	* Jekyll 과 Git 의 이해는 그 다음 문제  
    	
    2. 윈도우즈 사용자 고려
    	* 가능은 하지만 cgwin 등 불편한 요소 존재 - 꼼수 테스트 필요
    	* Jekyll 자체는 GitHub Pages 에서 동작하고 있으므로 로컬에 Jekyll 을 설치하는 것은 엄청 중요한 문제는 아닐 수 있음
    	* Jekyll 을 설치하지 않게 되면 Jekyll 을 설치하는데 필요한 Ruby 등을 따로 설치할 필요가 없어짐
    	* 원칙을 따르는 방법은 [Windows에서 Github Page와 Jekyll로 블로그 생성하기](http://hurderella.tistory.com/131) 와 [Jekyll 윈도우에 설치해서 사용하기](http://tech.whatap.io/2015/09/11/install-jekyll-on-windows/) 라는 두개의 글을 참고합니다. [^hurderella-131] [^whatap--jekyll-on-windows]
    	
    3. Jekyll 버전에 따른 변화
		* minima 등 gem-based theme 를 사용하는 변화 일어남
    	
2. GitHub Pages 에 계정 및 저장소 만들기
3. Jekyll 다운 받고 블로그 양식 만들기 : 윈도우즈 사용자들은 4번으로 이동하는 링크 넣기
4. 윈도우즈에서 Jekyll 블로그 만들기 : Jekyll 다운 필요없이 기초 양식을 저장소에서 받으면 됨
5. 마크다운 문서로 블로그 내용 채우기
6. git push 로 GitHub Pages 에 블로그 배포하기

### 추가 목차

7. Git 명령 이해하기 : 블로그를 Git으로 버전 관리할 수 있음
8. Jekyll 내부 구조 이해하기 : yaml 및 liquid 문법 이해하기
9. Disqus 게시판 달기 : 댓글 시스템 등의 동적 요소 추가하기
10. 테마 적용으로 블로그 꾸미기
11. 카테고리 기능 구현하기
