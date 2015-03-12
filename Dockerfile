FROM hpess/jre
MAINTAINER Karl Stoney <karl.stoney@hp.com> 

ENV LS_PKG_NAME logstash-1.4.2

# Install logstash.
RUN cd /opt && \
    wget --quiet https://download.elasticsearch.org/logstash/logstash/$LS_PKG_NAME.tar.gz && \
    tar xzf $LS_PKG_NAME.tar.gz && \
    rm -f $LS_PKG_NAME.tar.gz  && \
    mv $LS_PKG_NAME logstash 

# Install contrib plugins
RUN /opt/logstash/bin/plugin install contrib

# Setup the service and cookbooks
COPY services/* /etc/supervisord.d/
COPY cookbooks/ /chef/cookbooks/

# Expose the ports
EXPOSE 9292 9303

# Setup the environment
ENV HPESS_ENV logstash
ENV chef_node_name logstash.docker.local
ENV chef_run_list logstash
