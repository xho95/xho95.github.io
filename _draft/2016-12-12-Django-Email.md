[Sending email](https://docs.djangoproject.com/en/1.10/topics/email/) : Django 공식 문서입니다.

[How to Send Email in a Django App](https://simpleisbetterthancomplex.com/tutorial/2016/06/13/how-to-send-email.html)

[Apache James Server 3](https://james.apache.org/server/3/install.html)

#### attachment 

[How to send pdf as an email attachment in Django](http://stackoverflow.com/questions/20717496/how-to-send-pdf-as-an-email-attachment-in-django)

[Sending emails with embedded images in Django](https://www.vlent.nl/weblog/2014/01/15/sending-emails-with-embedded-images-in-django/) : 삽입된 이미지를 가지고 메일 보내는 방법에 대해서 설명한 글인듯 합니다. 나중에 살펴봐야합니다.

### STMP mail server

[SendGrid](https://sendgrid.com/docs/Integrate/Frameworks/django.html)

#### AWS

[AWS 메일 서버 ( Email Server ) 구축](http://m.blog.naver.com/amazonwebservices/220660237575)

[django-ses/django-ses](https://github.com/django-ses/django-ses)

[Django와 AWS SES를 연동하기](https://andromedarabbit.net/wp/django와-aws-ses를-연동하기/)

[Amazon SES](https://aws.amazon.com/ko/ses/?sc_channel=PS&sc_campaign=acquisition_KR&sc_publisher=google&sc_medium=english_ses_b&sc_content=ses_bmm&sc_detail=%2Baws%20%2Bses&sc_category=ses&sc_segment=117271567968&sc_matchtype=b&sc_country=KR&s_kwcid=AL!4422!3!117271567968!b!!g!!%2Baws%20%2Bses&ef_id=V@hnKQAABPtIKTfi:20161216082617:s)

[How to Send an Email with boto and SES](http://stackabuse.com/how-to-send-an-email-with-boto-and-ses/)

#### Google SMTP setting

[Python Django Gmail SMTP setup](http://stackoverflow.com/questions/19264907/python-django-gmail-smtp-setup)

[Send email using Django and Gmail SMTP](http://jstricks.com/send-email-using-django-gmail-smtp/)

[SMTP for free users](https://help.pythonanywhere.com/pages/SMTPForFreeUsers/) : 일단은 가장 좋은 자료인 듯 합니다. 

[Sign in using App Passwords](https://support.google.com/accounts/answer/185833?hl=en)

**settings.py**

```
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_HOST_USER = 'my gmail account'
EMAIL_HOST_PASSWORD = 'my gmail account password'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
DEFAULT_FROM_EMAIL = 'my gmail account'
DEFAULT_TO_EMAIL = 'to email'
```

**views.py**

```
from django.conf import settings
from django.core.mail import send_mail

send_mail('Subject here', 'Here is the message.', settings.EMAIL_HOST_USER, ['to@example.com'], fail_silently=False)
```

#### Sendgrid

[elbuo8/sendgrid-django](https://github.com/elbuo8/sendgrid-django)

#### MailGun

[Integrating Email service with Django using Mailgun](http://blog.narenarya.in/email-service-django.html)

### Python

[Python으로 SMTP을 이용하여 메일발송 하기](http://blog.saltfactory.net/python/send-mail-via-smtp-and-python.html)

### Authentication with email

[Django - authentication, registration with email confirmation](http://stackoverflow.com/questions/6488384/django-authentication-registration-with-email-confirmation) : 이메일 인증 방법에 대한 답변 글입니다. 여기서도 [django-allauth](https://github.com/pennersr/django-allauth)를 추천하고 있는 것 같습니다.