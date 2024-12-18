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
- Clone the analysis repository:
```
git clone https://github.com/YuvalShaul/analysis.git
```
- Install docker using a script:
```
cd analysis/util
source install_docker_ubuntu
```

## RUN

- Start docker compose:
```
docker compose up -d
```

