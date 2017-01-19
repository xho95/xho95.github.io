### 이메일 보내기

파이썬(Python) 자체로도  **smtplib** 모듈을 이용해서 메일을 쉽게 보낼 수 있지만, 장고(Django)는 그것을 더 편하게 만드는 랩퍼를 몇 개 제공합니다. 이것으로 메일을 진짜 빨리 보낼 수 있고, 개발 중에 쉽게 메일 테스트를 하며, SMTP를 사용할 수 없는 플랫폼에서도 메일을 보낼 수 있습니다.

코드는 **django.core.mail** 모듈에 있습니다.

#### 간단하게 살펴보기

아래의 두 줄이 핵심입니다(?):

```python
from django.core.mail import send_mail

send_mail(
    'Subject here',
    'Here is the message.',
    'from@example.com',
    ['to@example.com'],
    fail_silently=False,
)
```

메일은 SMTP 호스트와 포트를 사용하여 전송되는데 이들은 **EMAIL_HOST** 와 **EMAIL_PORT** 설정에서 지정합니다. **EMAIL\_HOST_USER** 와 **EMAIL\_HOST_PASSWORD** 설정은 SMTP 서버를 인증하는데 사용되고, **EMAIL\_USE_TLS** 와 **EMAIL\_USE_SSL** 설정은 보안 연결을 사용할지를 지정합니다.

> **django.core.mail** 로 메일을 보내는데 사용되는  문자셋은 **DEFAULT_CHARSET** 설정에 지정된 값을 따릅니다.

### `send_mail()`

```
send_mail(subject, message, from_email, recipient_list, fail_silently=False, auth_user=None, auth_password=None, connection=None, html_message=None)
```

메일을 보내는 가장 간단한 방법은 **django.core.mail.send_mail()** 을 사용하는 것입니다.

**subject**, **message**, **from_email** and **recipient_list** 값들이 필요합니다.

* **subject**: 문자열 타입.
* **message**: 문자열 타입.
* **from_email**: 문자열 타입.
* **recipient_list**: 문자열 리스트, 각각은 메일 주소. 이 `recipient_list`에 있는 각 멤버들은 다른 멤버들을 이메일 메시지의 `To:` 필드에서 확인할 수 있습니다.
* **fail_silently**: 불린(boolean) 타입. 이 값이 **False** 면 **send_mail** 은 **smtplib.SMTPException** 예외를 발생합니다. 가능한 예외의 목록은 **smtplib** 문서를 보면 확인할 수 있으며, 모든 예외들은 **SMTPException** 클래스를 상속받은 클래스입니다.
* **auth_user**: SMTP 서버에서 인증을 받기위한 사용자 이름으로 선택 사항입니다. 이 값이 없으면 장고는 **EMAIL_HOST_USER** 설정의 값을 사용합니다.
* **auth_password**: SMTP 서버에서 인증을 받기위한 사용자 비밀번호로 선택 사항입니다. 이 값이 없으면 장고는 **EMAIL_HOST_PASSWORD** 설정의 값을 사용합니다.
* **connection**: 메일을 보낼 때 사용하는 이메일 백엔드 (엔진?)으로 선택 사항입니다. 지정하지 않으면 기본 백엔드의 인스턴스가 사용됩니다. 더 자세한 내용은  이 문서의 Email backends 부분을 보도록 합니다.
* **html_message**: **html_message** 가 제공되면, 이메일 결과는 `multipart/alternative`이 되며, **message** 는 `text/plain`  타입으로 **html_message** 는 `text/html` 타입으로 내용이 전달됩니다.

반환 값은 성공적으로 전달된 메시지의 개수입니다. (하나의 메시지만 보낼 경우 **0** 또는 **1** 이 될 수 있습니다.)

### `send_mass_mail()`

```
send_mass_mail(datatuple, fail_silently=False, auth_user=None, auth_password=None, connection=None)
```
**django.core.mail.send_mass_mail()** 는 대량의 메일을 처리하기 위한 것입니다.

**datatuple** 는 아래의 포맷을 각각의 요소로 가지는 튜플입니다:

```
(subject, message, from_email, recipient_list)
```

**fail_silently**, **auth_user** 와 **auth_password** 는 **send_mail()** 에서와 같은 기능을 합니다.

**datatuple** 의 각 개별 요소는 개별 메일 메시지에서 유래합니다. **send_mail()**에서 보면, **recipient_list** 에 있는 수취인들은 이메일 메시지의 `To:` 필드에서 다른 모든 주소들을 볼 것입니다.

예를 들어, 아래의 코드는 두 개의 메시지를 두 명의 수취인에게 보냅니다; 하지만, 메일 서버와의 연결은 하나면 열리게 됩니다:

```
message1 = ('Subject here', 'Here is the message', 'from@example.com', ['first@example.com', 'other@example.com'])
message2 = ('Another Subject', 'Here is another message', 'from@example.com', ['second@test.com'])
send_mass_mail((message1, message2), fail_silently=False)
```

반환 값은 성공적으로 전송된 메시지의 개수입니다.

#### `send_mass_mail()` vs. `send_mail()`

**send_mass_mail()** 와 **send_mail()** 의 가장 큰 차이점은 **send_mail()** 은 매 번 실행될 때마다 메일 서버와의 연결을 여는 반면, **send_mass_mail()** 은 모든 메시지에 대해 한 번의 연결만을 사용한다는 점입니다. 따라서 **send_mass_mail()** 가 조금 더 효율적입니다.

### `mail_admins()`

```
mail_admins(subject, message, fail_silently=False, connection=None, html_message=None)
```

**django.core.mail.mail_admins()** 은 사이트 최고 관리자에게 메일을 보내는 지름길입니다, 이는 **ADMINS** 설정에서 정의합니다.

**mail_admins()** 는 **EMAIL_SUBJECT_PREFIX** 설정 값으로 제목에 접두사를 붙입니다. 기본 값은 `[Django] ` 입니다.

메일의 `From:` 머리말은 **SERVER_EMAIL** 설정의 값이 됩니다.

이 메소드는 편의성과 가독성을 위해 존재합니다.

**html_message** 가 제공되면, 이메일 결과는 `multipart/alternative`이 되며, **message** 는 `text/plain`  타입으로 **html_message** 는 `text/html` 타입으로 내용이 전달됩니다.

### `mail_managers()`

```
mail_managers(subject, message, fail_silently=False, connection=None, html_message=None)
```

**django.core.mail.mail_managers()** 는 사실상  **mail_admins()** 과 같습니다. 다만 이것은 **MANAGERS** 설정에 정의된 대로 사이트 관리자들에게 메일을 보냅니다.

### 예제

아래는 하나의 메일을 `john@example.com` 과 `jane@example.com` 에 보냅니다. 둘 모두 `To:` 에 나타납니다:

```
send_mail(
    'Subject',
    'Message.',
    'from@example.com',
    ['john@example.com', 'jane@example.com'],
)
```

아래는 `john@example.com` 과 `jane@example.com`에게 메시지를 보내는데, 둘은 서로 다른 메일을 받게됩니다.:

```
datatuple = (
    ('Subject', 'Message.', 'from@example.com', ['john@example.com']),
    ('Subject', 'Message.', 'from@example.com', ['jane@example.com']),
)
send_mass_mail(datatuple)
```

### 머리말 침입(header injection) 막기 

머리말 침입은 보안 탈취(security exploit)의 하나로 공격자가 추가적인 머리말을 `To:` 와 `From:` 에 삽입하는 것입니다.

장고 이메일 함수들은 모든 머리말 침임 공격을 머리말 값에 개행을 금지함으로써 막고 있습니다(?). 만약 **subject**, **from_email** 또는 **recipient_list** 어디서든  (Unix든 Windows든 Mac 스타일이든 상관없이) 개행문자를 가지고 있으면, 이메일 함수(가령 **send_mail()**)들은 **django.core.mail.BadHeaderError** 예외를 발생합니다. (**ValueError**를 상속받은 클래스입니다.) 따라서 메일을 보내지 않습니다. 데이터를 이메일 함수들에 전달하기 전에 유효성을 검사하는 것은 당신의 책임입니다.

만약 **message** 가 문자열의 처음에 머리말을 포함하고 있으면, 그 머리말은 단순히 이메일 메시지의 처음 부분에 출력됩니다.

아래는 **subject**, **message** 및 **from_email** 을 요청(request)의 POST 데이터로 받아서, `admin@example.com`로 보낸 다음에 `/contact/thanks/`로 이동하는 예제입니다:

```
from django.core.mail import send_mail, BadHeaderError
from django.http import HttpResponse, HttpResponseRedirect

def send_email(request):
    subject = request.POST.get('subject', '')
    message = request.POST.get('message', '')
    from_email = request.POST.get('from_email', '')
    if subject and message and from_email:
        try:
            send_mail(subject, message, from_email, ['admin@example.com'])
        except BadHeaderError:
            return HttpResponse('Invalid header found.')
        return HttpResponseRedirect('/contact/thanks/')
    else:
        # In reality we'd use a form class
        # to get proper validation errors.
        return HttpResponse('Make sure all fields are entered and valid.')
```

### **EmailMessage** 클래스

장고의 **send_mail()** 과 **send\_mass_mail()** 함수는 실제로는 **EmailMessage** 클래스를 사용해서 만든 가벼운 래퍼입니다.

**EmailMessage** 클래스의 모든 기능을 **send_mail()** 등의 래퍼 함수들에서 쓸 수 있는 것은 아닙니다. 좀 더 막강한 기능들, 예를 들어 숨은 참조(BCC)를 이용한 수취인 기능이나 파일 첨부 또는 멀티미디어?(multi-part) 메일 등을 사용하려면 직접 **EmailMessage** 인스턴스를 만들어야 합니다.

> 이것은 설계와 관련한 특성입니다. **send_mail()** 등의 함수들은 원래 장고에서만 제공하는 인터페이스였습니다. 하지만 시간이 흐르면서 점차 여러 변수들이 도입되고 있습니다. 이것은 이메일 메시지에 점점 더 객체 지향 설계 기법을 도입하고 하위 호환을 위해 기본 기능들을 유지하는 것이 이치에 맞음을 의미합니다.

**EmailMessage** 는 이메일 메시지 자체를 만드는데 역할을 합니다. 이메일 백엔드(email backend)가 메일을 보내는 데 역할을 합니다.

편의를 위해 **EmailMessage** 는 하나의 메일을 보내기 위해 **send()** 메소드를 제공합니다. 만약 여러 개의 메시지를 보내고 싶으면, 이메일 백엔드 API 가 대안을 제공합니다.

#### EmailMessage 객체

```
class EmailMessage
```

The **EmailMessage** class is initialized with the following parameters (in the given order, if positional arguments are used). All parameters are optional and can be set at any time prior to calling the **send()** method.

* **subject**: The subject line of the email.
* **body**: The body text. This should be a plain text message.
* **from_email**: The sender’s address. Both **fred@example.com** and **Fred \<fred@example.com>** forms are legal. If omitted, the **DEFAULT_FROM_EMAIL** setting is used.
* **to**: A list or tuple of recipient addresses.
* **bcc**: A list or tuple of addresses used in the “Bcc” header when sending the email.
* **connection**: An email backend instance. Use this parameter if you want to use the same connection for multiple messages. If omitted, a new connection is created when **send()** is called.
* **attachments**: A list of attachments to put on the message. These can be either **email.MIMEBase.MIMEBase** instances, or **(filename, content, mimetype)** triples.
* **headers**: A dictionary of extra headers to put on the message. The keys are the header name, values are the header values. It’s up to the caller to ensure header names and values are in the correct format for an email message. The corresponding attribute is **extra_headers**.
* **cc**: A list or tuple of recipient addresses used in the “Cc” header when sending the email.
* **reply_to**: A list or tuple of recipient addresses used in the “Reply-To” header when sending the email.

예를 들면:

```
from django.core.mail import EmailMessage

email = EmailMessage(
    'Hello',
    'Body goes here',
    'from@example.com',
    ['to1@example.com', 'to2@example.com'],
    ['bcc@example.com'],
    reply_to=['another@example.com'],
    headers={'Message-ID': 'foo'},
)
```

이 클래스는 다음의 메소드를 가집니다:

* **send(fail_silently=False)** sends the message. If a connection was specified when the email was constructed, that connection will be used. Otherwise, an instance of the default backend will be instantiated and used. If the keyword argument **fail_silently** is **True**, exceptions raised while sending the message will be quashed. An empty list of recipients will not raise an exception.

* **message()** constructs a **django.core.mail.SafeMIMEText** object (a subclass of Python’s **email.MIMEText.MIMEText** class) or a **django.core.mail.SafeMIMEMultipart** object holding the message to be sent. If you ever need to extend the **EmailMessage** class, you’ll probably want to override this method to put the content you want into the MIME object.

* **recipients()** returns a list of all the recipients of the message, whether they’re recorded in the **to**, **cc** or **bcc** attributes. This is another method you might need to override when subclassing, because the SMTP server needs to be told the full list of recipients when the message is sent. If you add another way to specify recipients in your class, they need to be returned from this method as well.

* **attach()** creates a new file attachment and adds it to the message. There are two ways to call **attach()**:

	* You can pass it a single argument that is an **email.MIMEBase.MIMEBase** instance. This will be inserted directly into the resulting message.

	* Alternatively, you can pass **attach()** three arguments: **filename**, **content** and **mimetype**. **filename** is the name of the file attachment as it will appear in the email, **content** is the data that will be contained inside the attachment and **mimetype** is the optional MIME type for the attachment. If you omit **mimetype**, the MIME content type will be guessed from the filename of the attachment.

		예를 들면:
		
		```
		message.attach('design.png', img_data, 'image/png')
		```
		
		If you specify a **mimetype** of **message/rfc822**, it will also accept **django.core.mail.EmailMessage** and **email.message.Message**.
		
		In addition, **message/rfc822** attachments will no longer be base64-encoded in violation of **RFC 2046#section-5.2.1**, which can cause issues with displaying the attachments in Evolution and Thunderbird.

* **attach_file()** creates a new attachment using a file from your filesystem. Call it with the path of the file to attach and, optionally, the MIME type to use for the attachment. If the MIME type is omitted, it will be guessed from the filename. The simplest use would be:

	```
	message.attach_file('/images/weather_map.png')
	```
	
**Sending alternative content types**

It can be useful to include multiple versions of the content in an email; the classic example is to send both text and HTML versions of a message. With Django’s email library, you can do this using the **EmailMultiAlternatives** class. This subclass of **EmailMessage** has an **attach_alternative()** method for including extra versions of the message body in the email. All the other methods (including the class initialization) are inherited directly from **EmailMessage**.

To send a text and HTML combination, you could write:

```
from django.core.mail import EmailMultiAlternatives

subject, from_email, to = 'hello', 'from@example.com', 'to@example.com'
text_content = 'This is an important message.'
html_content = '<p>This is an <strong>important</strong> message.</p>'
msg = EmailMultiAlternatives(subject, text_content, from_email, [to])
msg.attach_alternative(html_content, "text/html")
msg.send()
```

By default, the MIME type of the **body** parameter in an **EmailMessage** is **"text/plain"**. It is good practice to leave this alone, because it guarantees that any recipient will be able to read the email, regardless of their mail client. However, if you are confident that your recipients can handle an alternative content type, you can use the **content_subtype** attribute on the **EmailMessage** class to change the main content type. The major type will always be **"text"**, but you can change the subtype. For example:

```
msg = EmailMessage(subject, html_content, from_email, [to])
msg.content_subtype = "html"  # Main content is now text/html
msg.send()
```

### Email backends

The actual sending of an email is handled by the email backend.

The email backend class has the following methods:

* **open()** instantiates a long-lived email-sending connection.
* **close()** closes the current email-sending connection.
* **send_messages(email_messages)** sends a list of **EmailMessage** objects. If the connection is not open, this call will implicitly open the connection, and close the connection afterwards. If the connection is already open, it will be left open after mail has been sent.

It can also be used as a context manager, which will automatically call **open()** and **close()** as needed:

```
from django.core import mail

with mail.get_connection() as connection:
    mail.EmailMessage(
        subject1, body1, from1, [to1],
        connection=connection,
    ).send()
    mail.EmailMessage(
        subject2, body2, from2, [to2],
        connection=connection,
    ).send()
```

#### Obtaining an instance of an email backend

The **get_connection()** function in **django.core.mail** returns an instance of the email backend that you can use.

```
get_connection(backend=None, fail_silently=False, *args, **kwargs)
```

By default, a call to **get_connection()** will return an instance of the email backend specified in **EMAIL_BACKEND**. If you specify the **backend** argument, an instance of that backend will be instantiated.

The **fail_silently** argument controls how the backend should handle errors. If **fail_silently** is True, exceptions during the email sending process will be silently ignored.

All other arguments are passed directly to the constructor of the email backend.

Django ships with several email sending backends. With the exception of the SMTP backend (which is the default), these backends are only useful during testing and development. If you have special email sending requirements, you can write your own email backend.

**SMTP backend**

```
class backends.smtp.EmailBackend(host=None, port=None, username=None, password=None, use_tls=None, fail_silently=False, use_ssl=None, timeout=None, ssl_keyfile=None, ssl_certfile=None, **kwargs)
```

This is the default backend. Email will be sent through a SMTP server.

The value for each argument is retrieved from the matching setting if the argument is **None**:

* **host**: **EMAIL_HOST**
* **port**: **EMAIL_PORT**
* **username**: **EMAIL_HOST_USER**
* **password**: **EMAIL_HOST_PASSWORD**
* **use_tls**: **EMAIL_USE_TLS**
* **use_ssl**: **EMAIL_USE_SSL**
* **timeout**: **EMAIL_TIMEOUT**
* **ssl_keyfile**: **EMAIL_SSL_KEYFILE**
* **ssl_certfile**: **EMAIL_SSL_CERTFILE**

The SMTP backend is the default configuration inherited by Django. If you want to specify it explicitly, put the following in your settings:

```
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
```

If unspecified, the default **timeout** will be the one provided by **socket.getdefaulttimeout()**, which defaults to **None** (no timeout). 

**Console backend**

Instead of sending out real emails the console backend just writes the emails that would be sent to the standard output. By default, the console backend writes to **stdout**. You can use a different stream-like object by providing the **stream** keyword argument when constructing the connection.

To specify this backend, put the following in your settings:

```
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
```

This backend is not intended for use in production – it is provided as a convenience that can be used during development.

**File backend**

The file backend writes emails to a file. A new file is created for each new session that is opened on this backend. The directory to which the files are written is either taken from the **EMAIL_FILE_PATH** setting or from the **file_path** keyword when creating a connection with **get_connection()**.

To specify this backend, put the following in your settings:

```
EMAIL_BACKEND = 'django.core.mail.backends.filebased.EmailBackend'
EMAIL_FILE_PATH = '/tmp/app-messages' # change this to a proper location
```

This backend is not intended for use in production – it is provided as a convenience that can be used during development.

**In-memory backend**

The **'locmem'** backend stores messages in a special attribute of the **django.core.mail** module. The **outbox** attribute is created when the first message is sent. It’s a list with an **EmailMessage** instance for each message that would be sent.

To specify this backend, put the following in your settings:

```
EMAIL_BACKEND = 'django.core.mail.backends.locmem.EmailBackend'
```

This backend is not intended for use in production – it is provided as a convenience that can be used during development and testing.

**Dummy backend**

As the name suggests the dummy backend does nothing with your messages. To specify this backend, put the following in your settings:

```
EMAIL_BACKEND = 'django.core.mail.backends.dummy.EmailBackend'
```

This backend is not intended for use in production – it is provided as a convenience that can be used during development.

#### Defining a custom email backend

If you need to change how emails are sent you can write your own email backend. The **EMAIL_BACKEND** setting in your settings file is then the Python import path for your backend class.

Custom email backends should subclass **BaseEmailBackend** that is located in the **django.core.mail.backends.base** module. A custom email backend must implement the **send_messages(email_messages)** method. This method receives a list of **EmailMessage** instances and returns the number of successfully delivered messages. If your backend has any concept of a persistent session or connection, you should also implement the **open()** and **close()** methods. Refer to **smtp.EmailBackend** for a reference implementation.

#### Sending multiple emails

Establishing and closing an SMTP connection (or any other network connection, for that matter) is an expensive process. If you have a lot of emails to send, it makes sense to reuse an SMTP connection, rather than creating and destroying a connection every time you want to send an email.

There are two ways you tell an email backend to reuse a connection.

Firstly, you can use the **send_messages()** method. **send_messages()** takes a list of **EmailMessage** instances (or subclasses), and sends them all using a single connection.

For example, if you have a function called **get_notification_email()** that returns a list of **EmailMessage** objects representing some periodic email you wish to send out, you could send these emails using a single call to send_messages:

```
from django.core import mail
connection = mail.get_connection()   # Use default email connection
messages = get_notification_email()
connection.send_messages(messages)
```

In this example, the call to **send_messages()** opens a connection on the backend, sends the list of messages, and then closes the connection again.

The second approach is to use the **open()** and **close()** methods on the email backend to manually control the connection. **send_messages()** will not manually open or close the connection if it is already open, so if you manually open the connection, you can control when it is closed. For example:

```
from django.core import mail
connection = mail.get_connection()

# Manually open the connection
connection.open()

# Construct an email message that uses the connection
email1 = mail.EmailMessage(
    'Hello',
    'Body goes here',
    'from@example.com',
    ['to1@example.com'],
    connection=connection,
)
email1.send() # Send the email

# Construct two more messages
email2 = mail.EmailMessage(
    'Hello',
    'Body goes here',
    'from@example.com',
    ['to2@example.com'],
)
email3 = mail.EmailMessage(
    'Hello',
    'Body goes here',
    'from@example.com',
    ['to3@example.com'],
)

# Send the two emails in a single call -
connection.send_messages([email2, email3])
# The connection was already open so send_messages() doesn't close it.
# We need to manually close the connection.
connection.close()
```

### Configuring email for development

There are times when you do not want Django to send emails at all. For example, while developing a website, you probably don’t want to send out thousands of emails – but you may want to validate that emails will be sent to the right people under the right conditions, and that those emails will contain the correct content.

The easiest way to configure email for local development is to use the console email backend. This backend redirects all email to stdout, allowing you to inspect the content of mail.

The file email backend can also be useful during development – this backend dumps the contents of every SMTP connection to a file that can be inspected at your leisure.

Another approach is to use a “dumb” SMTP server that receives the emails locally and displays them to the terminal, but does not actually send anything. Python has a built-in way to accomplish this with a single command:

```
python -m smtpd -n -c DebuggingServer localhost:1025
```

This command will start a simple SMTP server listening on port 1025 of localhost. This server simply prints to standard output all email headers and the email body. You then only need to set the **EMAIL_HOST** and **EMAIL_PORT** accordingly. For a more detailed discussion of SMTP server options, see the Python documentation for the **smtpd** module.

For information about unit-testing the sending of emails in your application, see the Email services section of the testing documentation.

### 링크

* 이전글 : Cryptographic signing
* 이후글 : Internationalization and localization