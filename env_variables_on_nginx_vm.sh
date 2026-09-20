env variables on nginx vm

# /etc/codesite.env
DJANGO_ENV=oracle
JUDGE0_AUTHN_TOKEN=
RAPIDAPI_KEY=
DJANGO_SECRET_KEY=

sudo systemctl edit codesite
sudo nano /etc/systemd/system/codesite.service
sudo vim /etc/systemd/system/codesite.service
EnvironmentFile=/etc/codesite.env

sudo systemctl daemon-reload && sudo systemctl restart codesite && sudo systemctl status codesite


