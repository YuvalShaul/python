## Installing jupyterhub

After initial preparations and running the server, you will have 30 users:
- user: student1  pass:student1
- user: student2  pass:student2  
. . .  
- user: student29  pass:student29
- user: student3  pass:student30
and also:  
user: yuval password:<....>  
which is the admin.  


### Preparations

- Install git:
```
sudo apt-get update
sudo apt install git-all
```
- Clone the python repository:
```
git clone https://github.com/YuvalShaul/python.git
```
- Install docker using a script:
```
cd python/util
source install_docker_ubuntu
```
## Replace customer name
- inside nginx directory, in all conf files
- inside init-letsecrypt.sh  file

## HTTPS Setup
- Run the HTTPS setup script (this will automatically stop Apache if it's running):
```
cd python/util
bash init-letsencrypt.sh
```

## RUN Jupyterhub
- CD to directory:
```
cd python/util
```
- If you want to build the image again:
```
docker compose build
```
- Start docker compose:
```
docker compose up -d
```
You can now access JupyterHub securely at https://<- your server name here ->

## Get student passwords
- type:  
```
cat /home/ubuntu/python/util/config/passwords.json
```
- If you want to recreate the passwords:
```
docker compose down
rm /home/ubuntu/python/util/config/passwords.json
docker compose up -d
```
(these are on the host, not inside a container)


## Certificate Renewal
Let's Encrypt certificates are valid for 90 days. To renew:
```
sudo certbot renew
```