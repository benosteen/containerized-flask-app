from ubuntu:18.04

ENV PROJECTNAME=app
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt-get update

RUN apt-get install -y iputils-ping python3-pip python3-dev python3-venv \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python

RUN useradd -ms /bin/bash appuser

RUN mkdir /opt/$PROJECTNAME && chown appuser:appuser /opt/$PROJECTNAME

ADD docker-files/entrypoint.sh /usr/local/sbin/entrypoint.sh

RUN chmod +x /usr/local/sbin/entrypoint.sh

WORKDIR /opt/$PROJECTNAME

ADD --chown=appuser:appuser app.cfg app-test.cfg main.py requirements.txt ./
ADD --chown=appuser:appuser app app

# Testing
ADD --chown=appuser:appuser requirements-test.txt ./
ADD --chown=appuser:appuser tests tests

USER appuser

RUN python -m pip install --user -r requirements.txt

# Testing
RUN python -m pip install --user -r requirements-test.txt

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]

EXPOSE 8080