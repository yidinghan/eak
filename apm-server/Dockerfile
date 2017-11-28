FROM docker.elastic.co/apm/apm-server:6.0.0
COPY apm-server.reference.yml /usr/share/apm-server/apm-server.yml
USER root
RUN chown apm-server /usr/share/apm-server/apm-server.yml
USER apm-server