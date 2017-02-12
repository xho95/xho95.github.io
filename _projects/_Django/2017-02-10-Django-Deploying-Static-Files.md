### Deploying static files

> See also
> 
> For an introduction to the use of django.contrib.staticfiles, see Managing static files (e.g. images, JavaScript, CSS).

#### Serving static files in production

The basic outline of putting static files into production is simple: run the collectstatic command when static files change, then arrange for the collected static files directory (STATIC_ROOT) to be moved to the static file server and served. Depending on STATICFILES_STORAGE, files may need to be moved to a new location manually or the post_process method of the Storage class might take care of that.

Of course, as with all deployment tasks, the devil’s in the details. Every production setup will be a bit different, so you’ll need to adapt the basic outline to fit your needs. Below are a few common patterns that might help.

**Serving the site and your static files from the same serve**

If you want to serve your static files from the same server that’s already serving your site, the process may look something like:

Push your code up to the deployment server.
On the server, run collectstatic to copy all the static files into STATIC_ROOT.
Configure your web server to serve the files in STATIC_ROOT under the URL STATIC_URL. For example, here’s how to do this with Apache and mod_wsgi.
You’ll probably want to automate this process, especially if you’ve got multiple web servers. There’s any number of ways to do this automation, but one option that many Django developers enjoy is Fabric.

Below, and in the following sections, we’ll show off a few example fabfiles (i.e. Fabric scripts) that automate these file deployment options. The syntax of a fabfile is fairly straightforward but won’t be covered here; consult Fabric’s documentation, for a complete explanation of the syntax.

So, a fabfile to deploy static files to a couple of web servers might look something like:

```
from fabric.api import *

# Hosts to deploy onto
env.hosts = ['www1.example.com', 'www2.example.com']

# Where your project code lives on the server
env.project_root = '/home/www/myproject'

def deploy_static():
    with cd(env.project_root):
        run('./manage.py collectstatic -v0 --noinput')
```
        
**Serving static files from a dedicated server**

Most larger Django sites use a separate Web server – i.e., one that’s not also running Django – for serving static files. This server often runs a different type of web server – faster but less full-featured. Some common choices are:

Nginx
A stripped-down version of Apache
Configuring these servers is out of scope of this document; check each server’s respective documentation for instructions.

Since your static file server won’t be running Django, you’ll need to modify the deployment strategy to look something like:

When your static files change, run collectstatic locally.
Push your local STATIC_ROOT up to the static file server into the directory that’s being served. rsync is a common choice for this step since it only needs to transfer the bits of static files that have changed.
Here’s how this might look in a fabfile:

```
from fabric.api import *
from fabric.contrib import project

# Where the static files get collected locally. Your STATIC_ROOT setting.
env.local_static_root = '/path/to/static'

# Where the static files should go remotely
env.remote_static_root = '/home/www/static.example.com'

@roles('static')
def deploy_static():
    local('./manage.py collectstatic')
    project.rsync_project(
        remote_dir=env.remote_static_root,
        local_dir=env.local_static_root,
        delete=True,
    )
```
    
**Serving static files from a cloud service or CDN**

Another common tactic is to serve static files from a cloud storage provider like Amazon’s S3 and/or a CDN (content delivery network). This lets you ignore the problems of serving static files and can often make for faster-loading Web pages (especially when using a CDN).

When using these services, the basic workflow would look a bit like the above, except that instead of using rsync to transfer your static files to the server you’d need to transfer the static files to the storage provider or CDN.

There’s any number of ways you might do this, but if the provider has an API a custom file storage backend will make the process incredibly simple. If you’ve written or are using a 3rd party custom storage backend, you can tell collectstatic to use it by setting STATICFILES_STORAGE to the storage engine.

For example, if you’ve written an S3 storage backend in myproject.storage.S3Storage you could use it with:

```
STATICFILES_STORAGE = 'myproject.storage.S3Storage'
```

Once that’s done, all you have to do is run collectstatic and your static files would be pushed through your storage package up to S3. If you later needed to switch to a different storage provider, it could be as simple as changing your STATICFILES_STORAGE setting.

For details on how you’d write one of these backends, see Writing a custom storage system. There are 3rd party apps available that provide storage backends for many common file storage APIs. A good starting point is the overview at djangopackages.com.

#### Learn more

For complete details on all the settings, commands, template tags, and other pieces included in django.contrib.staticfiles, see the staticfiles reference.