FROM consol/ubuntu-xfce-vnc

USER 0

RUN set -eux
RUN apt-get update
RUN apt-get install -y --no-install-recommends bzip2 unzip xz-utils fontconfig libfreetype6 openjdk-8-jdk curl libswt-gtk-3-jni libswt-gtk-3-java tree
RUN rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV JAVA_HOME /usr/local/openjdk-8
ENV PATH $JAVA_HOME/bin:$PATH

ENV VERSION 5.2.0
ADD https://github.com/dbeaver/dbeaver/releases/download/${VERSION}/dbeaver-ce_${VERSION}_amd64.deb .
RUN dpkg -i dbeaver-ce_${VERSION}_amd64.deb

USER 1000

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]

CMD ["--wait"]
