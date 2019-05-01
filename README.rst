==================================
A demonstration python application
==================================

This repository demonstrates the recommended structure for a python application, in this case a Hello World Flask application.

Local usage
-----------

- Pre-requisites: ``python3`` and ``pip``

**Running the application**::

    [local] $ python -m venv venv
    [local] $ . venv/bin/activate
    (venv) [local] $ pip install -r requirements.txt
    Collecting Flask (from -r requirements.txt (line 1))
      Downloading https://files.pythonhosted.org/packages/7f/e7/08578774ed4536d3242b14dacb4696386634607af824ea997202cd0edb4b/Flask-1.0.2-py2.py3-none-any.whl (91kB)
      ............ [other download output removed] ..............
    Installing collected packages: Werkzeug, itsdangerous, MarkupSafe, Jinja2, click, Flask, urllib3, certifi, idna, chardet, requests
    Successfully installed Flask-1.0.2 Jinja2-2.10.1 MarkupSafe-1.1.1 Werkzeug-0.15.2 certifi-2019.3.9 chardet-3.0.4 click-7.0 idna-2.8 itsdangerous-1.1.0 requests-2.21.0 urllib3-1.24.2
    (venv) [local] $ 
     * Serving Flask app "app/app.py"
     * Environment: production
       WARNING: Do not use the development server in a production environment.
       Use a production WSGI server instead.
     * Debug mode: off
     * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
    (venv) [local] $ deactivate    # to leave the venv
    [local] $ 

**Developing the application**::

    (Create the venv and install the base requirements.txt as above)
    (venv) [local] $ pip install -r requirements-dev.txt


Containerization
----------------

**What does the ``Dockerfile`` do?**

- Starts with a basic OS image (``ubuntu:18.04`` in this case)
- Sets some core envirnoment variables such as locale
- creates a non-privileged user and work directory for the application
- installs system-wide libraries such as ``python3``, ``python3-dev``
- adds the entrypoint script that is the defining process for the container
- copies the necessary app files to the image
- switches to the non-privileged user within the image
- installs the python requirements for the app from ``requirements.txt``
- Sets the entrypoint to be the entrypoint script

**What does the ``docker-compose.yml`` file do?**

Creates two ``services``, the ``helloworld`` service and an ``nginx`` container. The ``helloworld`` application is a
web application, and as a matter of good practice, the web server should not be run as a privileged user and certainly
not as the root user. In this case, the Flask application is run as a basic user and on a high port number (``8080``).

The ``nginx`` service is set up to proxy content from the ``helloword`` service, and provide it on port 80. This is a
useful separation of concerns - the web service only needs to care about the delivery and security of its application,
and the proxy service is service that requires to be present on an ingress network, can handle the HTTPS handshakes on
behalf of its web service(s) without configuring all the web services to have certificates installed. The standard
``nginx`` image is in wide use on the internet, and can be further hardened to a respectable degree.
