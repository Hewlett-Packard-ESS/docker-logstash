![Logstash](/logstash.png?raw=true "Logstash")

This container builds on hpess/jre by adding Logstash. Currently installing logstash 1.4.2

## Use
Out of the box, we set up a simple udp json listener which pumps data into elasticsearch without really doing much.

An exmaple docker-compose file would be:
```
logstash:
  image: hpess/logstash
  hostname: logstash
  environment:
    udp_tags:    'tag1,tag2'
    udp_codec:   'json'
    elastic_url: 'http://elasticsearch:9200'                                                                          
  ports:
    - "9303:9303/udp"
```
Default values are:
``` 
  udp_tags:    'udp_in'
  udp_codec:   'json'
  elastic_url: 'http://elasticsearch:9200'
```

Or if you prefer, stick your own config in /storage/logstash.conf

## License
This docker application is distributed unter the MIT License (MIT).

Logstash itself is licenced under the [Apache](https://github.com/elastic/logstash/blob/master/LICENSE) License.
