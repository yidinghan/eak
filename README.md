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

# Remarks
 - with compose 2.2 feature, [healthcheck](https://docs.docker.com/compose/compose-file/compose-file-v2/#healthcheck)
   - your may need to wait a while in the `up` stage
   - because kibana depends on es
   - apm-server depends on es and kibana
 - apm-server may exit before elasticsearch is ready
   - exit status could be found by `docker-compose ps`
   - once exit then you should restart it, like `docker-compose up -d`

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
 - elastic-apm-server
   - image: `docker pull playdingnow/elastic-apm-server:v1.1`
   - repo: https://github.com/yidinghan/elastic-apm-server