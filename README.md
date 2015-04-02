![Logstash](/logstash.png?raw=true "Logstash")

This container builds on hpess/jre by adding Logstash. Currently installing logstash 1.5.0-rc2

## Use
Out of the box, we set up a simple udp json listener which pumps data into elasticsearch without really doing much.

An exmaple docker-compose file would be:
```
logstash:
  image: hpess/logstash
  hostname: logstash
  environment:
    udp_tags:      'tag1,tag2'
    udp_codec:     'json'
    elastic_url:   'elasticsearch:9200'
	elastic_proto: 'http' 
  ports:
    - "9303:9303/udp"
```
Default values are:
``` 
  udp_tags:      'udp_in'
  udp_codec:     'json'
  elastic_url:   'elasticsearch:9200'
  elastic_proto: 'http'
```

Or if you prefer, stick your own config in /storage/logstash.conf

## Plugins
Logstash has changed the way it handles plugins quite dramatically, the contrib package no longer exists and instead you install specific plugins.  I didn't want to bloat this image with plugins not everybody uses so subsequently I have left it to you to decide what plugins you want.  The included `docker-compose` file shows how to build an image with the plugins you need.

## License
This docker application is distributed unter the MIT License (MIT).

Logstash itself is licenced under the [Apache](https://github.com/elastic/logstash/blob/master/LICENSE) License.
