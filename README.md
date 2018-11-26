# EAK

- [EAK](#eak)
- [Quick Run](#quick-run)
- [Remarks](#remarks)
- [Resources](#resources)
- [Waterline](#waterline)
  - [Example](#example)

elasticsearch apm-server kibana

# Quick Run

```sh
wget https://raw.githubusercontent.com/yidinghan/eak/master/docker-compose.yml
docker-compose up -d
```

Go to `localhost:5601`, or what your machine IP

Wait for kibana to be available, then you are ready to try apm

# Remarks

- Since v6.4, apm dashboard setup move to Kibana UI.

  ![](https://github.com/yidinghan/eak/raw/master/images/apm-setup-instructions.jpg)
  ![](https://github.com/yidinghan/eak/raw/master/images/load-kibana-objects.jpg)

- with [apm-agent-nodejs:v1.1.0](https://github.com/elastic/apm-agent-nodejs/tree/v1.1.0)

  - start method

  ```js
  // change from
  require('elastic-apm-node/start');
  // to
  require('elastic-apm-node').start();
  ```

  - `elastic-apm-node.js` config change

  ```js
  // change from
  appName: 'apm-reseach',
  // to
  serviceName: 'apm-reseach',
  ```

- with [docker.elastic.co/kibana/kibana:6.2.2](https://github.com/elastic/kibana/tree/6.2.2)

  - New tab `APM` is ready to go

  ![](http://om4h4iqhe.bkt.clouddn.com/kibana-apm-services.jpg)
  ![](http://om4h4iqhe.bkt.clouddn.com/kibana-apm-service.jpg)
  ![](http://om4h4iqhe.bkt.clouddn.com/kibana-apm-request.jpg)
  ![](http://om4h4iqhe.bkt.clouddn.com/kibana-apm-pg-span.jpg)

- with [playdingnow/elastic-apm-server:1.5.0](https://github.com/yidinghan/elastic-apm-server/tree/1.5.0)
  - drop `Waterline` from dashboard temporary
- with [docker.elastic.co/kibana/kibana:6.1.1](https://github.com/elastic/kibana/tree/6.1.1)

  - A new tab named `APM` appears in the left sidebar

  ![](http://om4h4iqhe.bkt.clouddn.com/kibana-tab-apm.jpg)

- with [playdingnow/elastic-apm-server:1.4.3](https://github.com/yidinghan/elastic-apm-server/tree/1.4.3)

  - The default `apm-dashboards.json` have been changed to customize [data](https://github.com/yidinghan/elastic-apm-server/blob/master/apm-dashboards.json)
  - One more `visualization` chart name is [Waterline](#waterline)

  ![](http://om4h4iqhe.bkt.clouddn.com/apm-waterline.jpg)

- with [playdingnow/elastic-apm-server:v1.2](https://github.com/yidinghan/elastic-apm-server/tree/v1.2)
  - The default secret_token have been changed from `''` to `xxVpmQB2HMzCL9PgBHVrnxjNXXw5J7bd79DFm6sjBJR5HPXDhcF8MSb3vv4bpg44`
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

  - image: `docker pull docker.elastic.co/elasticsearch/elasticsearch:6.5.1`
  - github: https://github.com/elastic/elasticsearch
  - docker: https://www.elastic.co/guide/en/elasticsearch/reference/6.0/docker.html
  - vm.max_map_count: https://github.com/docker-library/elasticsearch/issues/111#issuecomment-268989731

  ```shell
  $ grep vm.max_map_count /etc/sysctl.conf
  vm.max_map_count=262144

  $ sysctl -w vm.max_map_count=262144
  ```

- apm-server
  - image: `docker pull docker.elastic.co/apm/apm-server:6.5.1`
  - github: https://github.com/elastic/apm-server
  - docker: https://www.elastic.co/guide/en/apm/server/current/running-on-docker.html
  - config: https://github.com/elastic/apm-server/blob/master/apm-server.reference.yml
- kibana
  - image: `docker pull docker.elastic.co/kibana/kibana:6.5.1`
  - github: https://github.com/elastic/kibana
  - docker: https://www.elastic.co/guide/en/kibana/6.0/docker.html
- apm agent
  - nodejs: https://www.elastic.co/guide/en/apm/agent/nodejs/current/intro.html
    - agent api: https://www.elastic.co/guide/en/apm/agent/nodejs/current/agent-api.html
    - github: https://github.com/elastic/apm-agent-nodejs

# Waterline

The higher the waterline, the higher the service load, formula is as follows

```js
waterline = sum([waterline_0, waterline_1, ..., waterline_n]) / count(duration)

waterline_x = count(duration, [border_x_start, border_x_end]) * a_x
```

Where

- duration is `transaction.duration.us`
- border_x is interval border, like [0, 100] means from 0ms to 100ms
- a_x is interval coefficient of border_x, like 1/2/100 or whatever you want

## Example

```js
waterline = ( count(duration, [0, 200]) * 1 + count(duration, [200, *]) * 2 ) / count(duration)
```

In a point

```js
10 = count(duration, [0, 200])
1 = count(duration, [200, *])
```

Then, in 3 decimal places precision

```js
waterline = ( 10 * 1 + 1 * 2 ) / 11 = 1.091
```
