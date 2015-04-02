def default_value(obj, value)
  return value if obj.nil?
  return obj
end

def parse(tags)
  return nil if tags.nil?
  tags.split(",").join('", "')
end

directory '/opt/logstash' do
  owner 'docker'
  group 'docker'
  action :create
  recursive true
end

config = { 
  :udp_tags     => default_value(parse(ENV['udp_tags']), '"udp_in"'),
  :udp_codec    => default_value(ENV['udp_codec'], 'json'),
  :elastic_url  => default_value(ENV['elastic_url'], 'elasticsearch:9200'),
  :elastic_proto  => default_value(ENV['elastic_proto'], 'http')
}

template '/storage/logstash.conf' do
  source    'logstash.conf.erb'
  variables config 
  owner     'docker'
  group     'docker'
  action    :create_if_missing
end
