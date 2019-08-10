Django 공식 문서에서 [Managing static files (e.g. images, JavaScript, CSS)](https://docs.djangoproject.com/en/1.10/howto/static-files/) 글에 Debug 모드와 Deployment 상황에서의 차이점에 대해서 설명되어 있습니다.

배포 시에는 아래와 같은 명령을 사용해서 하나의 폴더에 static 파일들을 모을 수 있다고 합니다. 

```
$ python manage.py collectstatic
```

Static 파일들을 배포하는 전략은 [Deploying static files](https://docs.djangoproject.com/en/1.10/howto/static-files/deployment/) 문서에 설명되어 있습니다. 
