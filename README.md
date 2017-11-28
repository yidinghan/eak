# EAK

elasticsearch apm-server kibana

# Resources
 - elastic docker: https://www.docker.elastic.co/
   - elasticsearch
     - docker: https://www.elastic.co/guide/en/elasticsearch/reference/6.0/docker.html
     - vm.max_map_count: https://github.com/docker-library/elasticsearch/issues/111#issuecomment-268989731
     ```shell
     $ grep vm.max_map_count /etc/sysctl.conf
     vm.max_map_count=262144
     
     $ sysctl -w vm.max_map_count=262144
     ```
