FROM hpess/jre
MAINTAINER Paul Cooke <paul.cooke@hp.com>

ENV LS_PKG_NAME logstash-1.4.2

# Install logstash.
RUN cd /opt && \
    wget https://download.elasticsearch.org/logstash/logstash/$LS_PKG_NAME.tar.gz && \
    tar xzvf $LS_PKG_NAME.tar.gz && \
    rm -f $LS_PKG_NAME.tar.gz  && \
    mv $LS_PKG_NAME logstash 

# Install contrib plugins
#RUN /opt/logstash/bin/plugin install contrib


# Kibana
EXPOSE 9292

# Start logstash
#ENTRYPOINT ["/bin/sh"]
#CMD ["/opt/logstash/bin/logstash", "-f", "/storage/logstash.conf"]

# Mount logstash.conf
ADD storage/logstash.conf /storage/logstash.conf
ADD logstash.service.conf /etc/supervisord.d/logstash.service.conf
