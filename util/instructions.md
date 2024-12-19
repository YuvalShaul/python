## Installing jupyterhub

After initial preparations and running the server, you will have 30 users:
- user: student1  pass:student1
- user: student2  pass:student2  
. . .  
- user: student29  pass:student29
- user: student3  pass:student30
and also:  
user: yuval password:yuval  
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
- Start docker compose:
```
docker compose up -d
```
You can now access JupyterHub securely at https://commtact.yuval.guide

## Get student passwords
- type:  
```
cat /etc/jupyterhub/passwords.json
```
- If you want to recreate the passwords:
```
sudo rm /etc/jupyterhub/passwords.json
```
(these are on the host, not inside a container)


## Certificate Renewal
Let's Encrypt certificates are valid for 90 days. To renew:
```
sudo certbot renew
```