장고(Django)에서 무료로 메일을 보내는 방법에 대해서 정리합니다.

단순히 설정의 문제였고, Gmail SMTP 서버는 설정만 잘하면 잘 됩니다. ㅜㅜ 

2단계 인증 등은 안해도 잘 됩니다. 

### 이슈 해결

localhost에서는 되는데 실서버에서는 안되는 문제가 있습니다. 

이 때 [Django - Gmail - SMTPAuthenticationError](https://www.digitalocean.com/community/questions/django-gmail-smtpauthenticationerror) 글에 나온대로 다음 (<https://accounts.google.com/DisplayUnlockCaptcha>) 의 주소로 이동해서 설정을 하면 문제가 해결됩니다. 

아직 원리는 모르겠습니다. 

브라우저에서 아래와 같은 메시지가 뜨면 다시 메일을 보낼 경우 잘 작동합니다. 

```
계정 액세스 사용 설정됨

새 기기 또는 애플리케이션에서 Google 계정에 다시 로그인해 보세요.
```

### 아래는 다른 내용입니다. 따로 정리를 할 지 생각해 봅니다. 

기본적으로 [PythonAnywhere](https://www.pythonanywhere.com) 의 [SMTP for free users](https://help.pythonanywhere.com/pages/SMTPForFreeUsers/) 글과 Google [Sign in using App Passwords](https://support.google.com/accounts/answer/185833?hl=en) 문서를 중심으로 정리한 글입니다. [^pythonanywhere] [^pythonanywhere-SMTP] [^google-185833]

### 무료 사용자를 위한 SMTP

Free users are restricted to HTTP/HTTPS only, to a whitelist of sites. Because most email services work over SMTP, which is not HTTP or HTTPS, that means you cannot normally use SMTP on Free accounts.

If you want to send email, you have two options:

#### Use an HTTP/HTTPS-based email service

Services like Mailgun or sendgrid allow you to send email using HTTP(S) requests, and their API endpoint are on our whitelist. This is the most reliable option, and works well so long as your code isn't limited to using SMTP.

#### Use Gmail's SMTP servers

We have added a special exception to our firewall rules for Gmail's SMTP servers. If you use them, it should work.

However, we have to hard-code the IP addresses of Google's servers into our firewall, and these sometimes change, which means that, on occasion, Google may switch to a new Gmail server which we don't know about, and that would temporarily block email until we are able to update the firewall.

One other thing that's quite important: we highly recommend you use an app-specific password instead of your normal Google login password for this. This has two advantages:

* Google's security systems sometimes block your first attempt to use their SMTP servers from a new IP address, which can be a pain if you're running code on different servers (which happens a lot on PythonAnywhere as we change our systems). They don't seem to do this for app-specific passwords.
* It's much better not having a copy of your main Google password on a third-party service like PythonAnywhere, because you can always revoke the password from the Google site if necessary, without having to log in here.

For Django, you can use the settings:

```
EMAIL_HOST = "smtp.gmail.com"
EMAIL_HOST_USER = "yourusername@gmail.com"
EMAIL_HOST_PASSWORD = 'yourpassword'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
```

#### Google security blocking and setting up an App-Specific password

Google sometimes blocks SMTP requests from IP addresses it doesn't recognise. If you're finding emails aren't getting sent, try visiting the security page on your Google account, and have a look for security notifications. You may need to approve some requests, or generate an application-specific password. This page is often a good starting point. (Some people have reported that they can't access the correct security settings on that page from the normal web interface and have to use a mobile device to see them there. Thanks, Google! ;-)

### Sign in using App Passwords

An App password is a 16-digit passcode that gives an app or device permission to access your Google Account. If you use 2-Step-Verification and are seeing a “password incorrect” error when trying to access your Google Account, an App password may solve the problem. Most of the time, you’ll only have to enter an App password once per app or device, so don’t worry about memorizing it.

> If you have iOS 8.3 or greater on your iPhone or OSX 10.10.3 on your Mac, you will no longer have to use App passwords to use 2-Step Verification when using the Gmail or any Google branded Apps from iTunes. Using the Google option on the native iOS mail client also does not require App passwords.

#### Why you may need an App password

When you sign up for 2-Step Verification, we normally send you verification codes. However, these codes do not work with some apps and devices, like Outlook. Instead, you’ll need to authorize the app or device the first time you use it to sign in to your Google Account by generating and entering an App password.

#### How to generate an App password

1. Visit your App passwords page. You may be asked to sign in to your Google Account.
2. At the bottom, click Select app and choose the app you’re using.
3. Click Select device and choose the device you’re using.
4. Select Generate.
5. Follow the instructions to enter the App password (the 16 character code in the yellow bar) on your device.
6. Select Done.

Once you are finished, you won’t see that App password code again. However, you will see a list of apps and devices you’ve created App passwords for.

> You may not be able to create an App password for less secure apps. Learn more about allowing less secure apps.

### 참고 자료

[^pythonanywhere]: [PythonAnywhere](https://www.pythonanywhere.com) : PythonAnywhere 공식 홈페이지입니다.

[^pythonanywhere-SMTP]: [SMTP for free users](https://help.pythonanywhere.com/pages/SMTPForFreeUsers/) : PythonAnywhere 라는 곳에서 Gmail SMTP 서버를 사용하는 방법을 정리한 글입니다.

[^google-185833]: [Sign in using App Passwords](https://support.google.com/accounts/answer/185833?hl=en)


