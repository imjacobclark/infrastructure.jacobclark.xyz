# Enable startup provisioner
echo "Enable startup provisioner"
systemctl enable startup-provisioner.service

# Install Docker Engine
echo "Bringing up the Docker engine"
apt-get update
apt-get install -y apt-transport-https ca-certificates curl
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge lxc-docker
apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
apt-get install -y docker-engine
service docker start

# Clone required repositories 
git clone https://github.com/imjacobclark/blog.jacob.uk.com.git /etc/blog.jacob.uk.com

# Spin up containers
echo "Bringing up main container infrastructure"
docker run --restart=always -d -p 80:80 --name nginx -v /etc/nginx.conf:/etc/nginx/nginx.conf nginx
docker run --restart=always -d -p 3000:3000 --name jacob.uk.com imjacobclark/jacob.uk.com
docker run --restart=always -d -p 3001:3000 --name ngaas.jacob.uk.com imjacobclark/ngaas
docker run --restart=always -d -p 3002:3000 --name api.devnews.today imjacobclark/devnews-core
docker run --restart=always -d -p 3003:3000 --name devnews.today imjacobclark/devnews-web
docker run --restart=always -d -p 3004:3000 --name cors-container imjacobclark/cors-container
docker run --restart=always -d -p 3005:4000 --volume=/etc/blog.jacob.uk.com:/srv/jekyll --name=jekyll jekyll/jekyll
docker run --restart=always -d --name=grafana -p 3006:3000 grafana/grafana
docker run --restart=always --volume=/:/rootfs:ro --volume=/var/run:/var/run:rw --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --publish=8080:8080 --detach=true --name=cadvisor google/cadvisor:latest
docker run --restart=always -d --name=prometheus -p 9090:9090 -v /etc/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus -config.file=/etc/prometheus/prometheus.yml -storage.local.path=/prometheus -storage.local.memory-chunks=10000
docker run --restart=always -d --name=node-exporter -p 9100:9100 -v "/proc:/host/proc" -v "/sys:/host/sys" -v "/:/rootfs" --net="host" prom/node-exporter -collector.procfs /host/proc -collector.sysfs /host/proc -collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"

#docker run --restart=always -d -p 3004:3000 -e DISCOGS_KEY='SZJTcWkygwiezOEEsxxw' -e DISCOGS_SECRET='' --name playlistr.jacob.uk.com imjacobclark/playlistr 
#docker run --restart=always -d -e TELEGRAM_BOT_TOKEN='' --name telegram-name-generator-bot imjacobclark/name-generator-telegram-bot
#docker run --restart=always -d -e TELEGRAM_BOT_TOKEN='' --name hacker-news-telegram-bot imjacobclark/hacker-news-telegram-bot
#docker run --restart=always -d --name blog.jacob.uk.com -p 2368:2368 -v /root/blog.jacob.uk.com:/var/lib/ghost -e NODE_ENV=production ghost 
#docker run --restart=always --name pylot.co.uk -v /root/pylot.co.uk:/usr/share/nginx/html:ro -d -p 3005:80 nginx
#docker run --restart=always --name mongo -p 3009:27017 -v /root/mongodb:/data/db -d mongo
#docker run -d --restart=always --name mongoui --link mongo:mongo -p 8081:8081 knickers/mongo-express
#docker run -d openhandsetdata --name openhandsetdata
#docker run --restart=always --name openphonebase.com -v /root/openphonebase.com:/usr/share/nginx/html:ro -d -p 3010:80 nginx
#docker run --name mysql -v /root/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-killer -d mysql:latest
#docker run --restart=always --name wanderingmanchester.co.uk --link mysql:mysql -p 3012:80 -d wordpress
#docker run --restart=always -d -p 6080:6080 --name houndd -v /root/hound.jacob.uk.com:/hound -v /home/jenkins/jobs:/builds etsy/hound