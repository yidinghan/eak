# EAK

elasticsearch apm-server kibana

# Quick Run

```sh
git pull https://github.com/yidinghan/eak.git
cd eak
docker-compose up -d
```

Go to `localhost:5601`, or what your IP is

Wait for kibana to be available, then you are ready to try apm

# Resources
   - docker elastic: https://www.docker.elastic.co/
   - elasticsearch
     - image: `docker pull docker.elastic.co/elasticsearch/elasticsearch:6.0.0`
     - docker: https://www.elastic.co/guide/en/elasticsearch/reference/6.0/docker.html
     - vm.max_map_count: https://github.com/docker-library/elasticsearch/issues/111#issuecomment-268989731
     ```shell
     $ grep vm.max_map_count /etc/sysctl.conf
     vm.max_map_count=262144
     
     $ sysctl -w vm.max_map_count=262144
     ```
   - apm-server
     - image: `docker pull docker.elastic.co/apm/apm-server:6.0.0`
     - docker: https://www.elastic.co/guide/en/apm/server/current/running-on-docker.html
     - config: https://github.com/elastic/apm-server/blob/master/apm-server.reference.yml
   - kibana
     - image: `docker pull docker.elastic.co/kibana/kibana:6.0.0`
     - docker: https://www.elastic.co/guide/en/kibana/6.0/docker.html
   - apm agent
     - nodejs: https://www.elastic.co/guide/en/apm/agent/nodejs/current/intro.html  
   
     
