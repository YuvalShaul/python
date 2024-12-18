#!/bin/bash

# Create users if they don't exist (needed for LocalProcessSpawner)
useradd -m -s /bin/bash yuval || echo "User yuval already exists"
useradd -m -s /bin/bash student1 || echo "User student1 already exists"
useradd -m -s /bin/bash student2 || echo "User student2 already exists"
useradd -m -s /bin/bash student3 || echo "User student3 already exists"
useradd -m -s /bin/bash student4 || echo "User student4 already exists"
useradd -m -s /bin/bash student5 || echo "User student5 already exists"
useradd -m -s /bin/bash student6 || echo "User student6 already exists"
useradd -m -s /bin/bash student7 || echo "User student7 already exists"
useradd -m -s /bin/bash student8 || echo "User student8 already exists"
useradd -m -s /bin/bash student9 || echo "User student9 already exists"
useradd -m -s /bin/bash student10 || echo "User student10 already exists"
useradd -m -s /bin/bash student11 || echo "User student11 already exists"
useradd -m -s /bin/bash student12 || echo "User student12 already exists"
useradd -m -s /bin/bash student13 || echo "User student13 already exists"
useradd -m -s /bin/bash student14 || echo "User student14 already exists"
useradd -m -s /bin/bash student15 || echo "User student15 already exists"
useradd -m -s /bin/bash student16 || echo "User student16 already exists"
useradd -m -s /bin/bash student17 || echo "User student17 already exists"
useradd -m -s /bin/bash student18 || echo "User student18 already exists"
useradd -m -s /bin/bash student19 || echo "User student19 already exists"
useradd -m -s /bin/bash student20 || echo "User student20 already exists"
useradd -m -s /bin/bash student21 || echo "User student21 already exists"
useradd -m -s /bin/bash student22 || echo "User student22 already exists"
useradd -m -s /bin/bash student23|| echo "User student23 already exists"
useradd -m -s /bin/bash student24|| echo "User student24 already exists"
useradd -m -s /bin/bash student25|| echo "User student25 already exists"
useradd -m -s /bin/bash student26|| echo "User student26 already exists"
useradd -m -s /bin/bash student27|| echo "User student27 already exists"
useradd -m -s /bin/bash student28|| echo "User student28 already exists"
useradd -m -s /bin/bash student29|| echo "User student29 already exists"
useradd -m -s /bin/bash student30|| echo "User student30 already exists"

# Print the credentials
echo "=========================="
echo "Credentials:"
echo "User: yuval  Password: pass_yuval"
echo "User: john   Password: pass_john"
echo "=========================="

# Start JupyterHub
jupyterhub -f /etc/jupyterhub/jupyterhub_config.py 
