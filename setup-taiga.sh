#! bin/bash
#this MUST be the hostname (host:port if needed) through witch you externally access your taiga (what you type IN your browser)
EXTERNAL_HOST=localhost

su - taiga <<EOF 
export DEBIAN_FRONTEND="noninteractive apt-get autoremove"
export LANG=en_US.utf8
git clone https://github.com/taigaio/taiga-scripts.git 
# because the scripts keep using this .setup directory but never create it , doh !
mkdir ~/.setup

cd taiga-scripts 
# swap the comment on these two next lines if you want a development instance (no nginx, no circus installed)
# you might then want to comment the "no debug" lines below and maybe remove the async stuff, up to you
bash setup-server.sh 
#bash setup-devel.sh 

# if you want public registration disabled uncomment this
sed -i "s|PUBLIC_REGISTER_ENABLED = True|PUBLIC_REGISTER_ENABLED = False|g" ~/taiga-back/settings/local.py

# adjusting the hostname (it should properly be done better in hone place in the scripts but I had no time to investigate it
sed -i "s|localhost:8000|$EXTERNAL_HOST|g" ~/taiga-back/settings/common.py
sed -i "s|localhost:8000|$EXTERNAL_HOST|g" ~/taiga-back/settings/local.py

#we are building a non debug instance here so 
# if you do want a debug / dev instance comment these two lines
sed -i "s|DEBUG = True|DEBUG = False|g" ~/taiga-back/settings/local.py
sed -i "s|TEMPLATE_DEBUG = True|TEMPLATE_DEBUG = False|g" ~/taiga-back/settings/local.py

# adding async
source ./scripts/setup-apt.sh
source ./scripts/setup-redis.sh
source ./scripts/setup-rabbitmq.sh
EOF

# adding async to local.py
cat <<'EOF' >> /home/taiga/taiga-back/settings/local.py
from .celery import *

BROKER_URL = 'amqp://guest:guest@localhost:5672//'
CELERY_RESULT_BACKEND = 'redis://localhost:6379/0'
CELERY_ENABLED = True

EOF

