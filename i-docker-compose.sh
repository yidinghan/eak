curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


rcfile='~/.bashrc'
echo 'alias d=docker' >> $rcfile
echo 'alias dc=docker-compose' >> $rcfile

echo "run cmd to use alias of d=docker and dc=docker-compose"
echo "        source \"${rcfile}\""