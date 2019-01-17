FROM andreptb/oracle-java:8-alpine

ENV ACTIVEMQ_VERSION 2.5.0
ENV ACTIVEMQ apache-artemis-$ACTIVEMQ_VERSION

ENV ACTIVEMQ_HOME /opt/activemq

RUN \
curl -O http://archive.apache.org/dist/activemq/activemq-artemis/$ACTIVEMQ_VERSION/$ACTIVEMQ-bin.tar.gz && \
mkdir -p /opt && \
tar xf $ACTIVEMQ-bin.tar.gz -C /opt/ && \
rm $ACTIVEMQ-bin.tar.gz && \
ln -s /opt/$ACTIVEMQ $ACTIVEMQ_HOME && \
useradd -r -M -d $ACTIVEMQ_HOME activemq && \
chown activemq:activemq /opt/$ACTIVEMQ -R

USER activemq

WORKDIR $ACTIVEMQ_HOME
EXPOSE 61616 8161

CMD ["/bin/bash", "-c", "bin/activemq console"]
