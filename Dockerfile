FROM hpess/jre:master
MAINTAINER Karl Stoney <karl.stoney@hp.com> 

ENV LS_PKG_NAME logstash-1.5.2

# Install logstash.
RUN cd /opt && \
    wget --quiet https://download.elasticsearch.org/logstash/logstash/$LS_PKG_NAME.tar.gz && \
    tar xzf $LS_PKG_NAME.tar.gz && \
    rm -f $LS_PKG_NAME.tar.gz  && \
    mv $LS_PKG_NAME logstash && \ 
    chown -R docker:docker /opt/logstash && \
    chown -R docker:docker /storage

# Install some plugins
RUN /opt/logstash/bin/plugin install logstash-codec-cef logstash-output-syslog logstash-filter-prune
   
# Setup the service and cookbooks
COPY services/* /etc/supervisord.d/
COPY cookbooks/ /chef/cookbooks/

# Expose the UDP port
EXPOSE 9303 

# Setup the environment
ENV HPESS_ENV logstash
ENV chef_node_name logstash.docker.local
ENV chef_run_list logstash
