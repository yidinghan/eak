curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


rcfile='~/.bashrc'
echo 'alias d=docker\n' >> $rcfile
echo 'alias dc=docker-compose\n' >> $rcfile
source $rcfile