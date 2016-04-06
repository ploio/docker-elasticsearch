# VERSION 5.0.0-alpha1
# AUTHOR:         Nicolas Lamirault <nicolas.lamirault@gmail.com>
# DESCRIPTION:    portefaix/elasticsearch

FROM portefaix/base:3.3
MAINTAINER Nicolas Lamirault <nicolas.lamirault@gmail.com>

ENV JAVA_VERSION=8 \
    JAVA_UPDATE=77 \
    JAVA_BUILD=03 \
    JAVA_PACKAGE=jdk \
    JAVA_HOME=/jre

ENV ES_VERSION 5.0.0-alpha1
ENV GLIBC_PKG_VERSION=2.23-r1

RUN apk add --update wget curl ca-certificates

WORKDIR /tmp

# Install glibc
RUN mkdir -p /etc/apk/keys/ && \
    apk --no-cache add ca-certificates && \
    wget -q --no-check-certificate -O /etc/apk/keys/andyshinn.rsa.pub https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/andyshinn.rsa.pub && \
    wget -q --no-check-certificate https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r1/glibc-2.23-r1.apk && \
    apk add glibc-2.23-r1.apk

# Install Oracle Java
RUN curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u77-b03/server-jre-8u77-linux-x64.tar.gz" -o /tmp/java.tar.gz && \
    tar -zxf /tmp/java.tar.gz && \
    mv /tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}/jre /jre && \
    rm /jre/bin/jjs && \
    rm /jre/bin/keytool && \
    rm /jre/bin/orbd && \
    rm /jre/bin/pack200 && \
    rm /jre/bin/policytool && \
    rm /jre/bin/rmid && \
    rm /jre/bin/rmiregistry && \
    rm /jre/bin/servertool && \
    rm /jre/bin/tnameserv && \
    rm /jre/bin/unpack200 && \
    rm /jre/lib/ext/nashorn.jar && \
    rm /jre/lib/jfr.jar && \
    rm -rf /jre/lib/jfr && \
    rm -rf /jre/lib/oblique-fonts && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

RUN curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" && \
	chmod +x /usr/local/bin/gosu

# Install Elasticsearch
RUN curl -Ls http://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/$ES_VERSION/elasticsearch-$ES_VERSION.tar.gz | tar -xz -C /usr/share && \
    mv /usr/share/elasticsearch-$ES_VERSION /usr/share/elasticsearch
COPY elasticsearch.yml /usr/share/elasticsearch/config/
COPY logging.yml /usr/share/elasticsearch/config/
COPY docker-entrypoint.sh /

RUN apk del curl wget ca-certificates && \
    rm -fr /tmp/* /var/cache/apk/*

ENV PATH /usr/share/elasticsearch/bin:$PATH

# Add elasticsearch user+group:
RUN addgroup -S elasticsearch && \
    adduser -S -G elasticsearch elasticsearch

RUN set -ex \
    && for path in \
       /usr/share/elasticsearch/data \
       /usr/share/elasticsearch/logs \
       /usr/share/elasticsearch/config \
       /usr/share/elasticsearch/config/scripts \
       ; do \
         mkdir -p "$path"; \
         chown -R elasticsearch:elasticsearch "$path"; \
       done

#RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install mobz/elasticsearch-head && \
#    /usr/share/elasticsearch/bin/elasticsearch-plugin install lmenezes/elasticsearch-kopf/2.0

VOLUME ["/usr/share/elasticsearch/data"]

EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["elasticsearch", "-Ees.network.host=0.0.0.0"]
