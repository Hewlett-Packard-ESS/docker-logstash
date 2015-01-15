FROM hpess/jre
MAINTAINER Paul Cooke <paul.cooke@hp.com>

ENV LS_PKG_NAME logstash-1.4.2

# Install logstash.
RUN cd /opt && \
    wget --quiet https://download.elasticsearch.org/logstash/logstash/$LS_PKG_NAME.tar.gz && \
    tar xzf $LS_PKG_NAME.tar.gz && \
    rm -f $LS_PKG_NAME.tar.gz  && \
    mv $LS_PKG_NAME logstash 

# Install contrib plugins
#RUN /opt/logstash/bin/plugin install contrib

# Kibana
EXPOSE 9292
EXPOSE 9303

# Add the services
COPY services/* /etc/supervisord.d/

# Mount logstash.conf
COPY storage/logstash/logstash.conf /storage/logstash/logstash.conf
