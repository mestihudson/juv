FROM consol/ubuntu-xfce-vnc


USER 0


ENV LANG C.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH
RUN set -eux
RUN apt-get update
RUN apt-get install -y --no-install-recommends bzip2 unzip xz-utils fontconfig libfreetype6 openjdk-8-jdk curl libswt-gtk-3-jni libswt-gtk-3-java tree adb
RUN rm -rf /var/lib/apt/lists/*


ENV DBEAVER_VERSION 5.2.0
RUN curl -sSL https://github.com/dbeaver/dbeaver/releases/download/${DBEAVER_VERSION}/dbeaver-ce_${DBEAVER_VERSION}_amd64.deb > dbeaver-ce_${DBEAVER_VERSION}_amd64.deb
RUN dpkg -i dbeaver-ce_${DBEAVER_VERSION}_amd64.deb
RUN rm -fv dbeaver-ce_${DBEAVER_VERSION}_amd64.deb


ENV GRADLE_VERSION 5.4.1
ENV GRADLE_HOME /opt/gradle
ENV PATH $GRADLE_HOME/bin:$PATH
RUN curl -sSL "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" > gradle.zip
RUN unzip gradle.zip
RUN rm -fv gradle.zip
RUN mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/"


ENV SDK_URL https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
ENV ANDROID_HOME /opt/android-sdk
ENV ANDROID_VERSION 28
ENV ANDROID_BUILD_TOOLS_VERSION 27.0.3
RUN curl -sSL $SDK_URL > sdk.zip
RUN unzip sdk.zip -d "$ANDROID_HOME"
RUN rm -fv sdk.zip


ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]
