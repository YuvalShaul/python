from traitlets.config import get_config
from jupyterhub.auth import DummyAuthenticator
from jupyterhub.spawner import LocalProcessSpawner
import secrets
import os
import random
import string
import json

print('Loading this file!!!')
c = get_config()

class MyDummyAuthenticator(DummyAuthenticator):
    def __init__(self):
        super().__init__()
        self.passwords = {
            'yuval': 'yuval'  # admin keeps simple password
        }
        
        # Generate and store student passwords
        for i in range(1, 31):
            username = f"student{i}"
            # Generate random 8-char password: 2 uppercase, 2 lowercase, 2 digits, 2 special
            password = (
                random.choices(string.ascii_uppercase, k=2) +
                random.choices(string.ascii_lowercase, k=2) +
                random.choices(string.digits, k=2) +
                random.choices('!@#$%^&*', k=2)
            )
            # Shuffle the characters
            random.shuffle(password)
            # Convert to string
            password = ''.join(password)
            self.passwords[username] = password
        
        # Save passwords to a file
        with open('/etc/jupyterhub/passwords.json', 'w') as f:
            json.dump(self.passwords, f, indent=4)
            
    async def authenticate(self, handler, data):
        username = data['username']
        password = data['password']
        if username in self.passwords and password == self.passwords[username]:
            return username
        return None

# Authentication settings
c.JupyterHub.authenticator_class = MyDummyAuthenticator
c.Authenticator.admin_users = {'yuval'}
names_dict = {f"student{num}" for num in range(1, 31)}
names_dict.add('yuval')
c.Authenticator.allowed_users = names_dict

# Basic Configuration
c.JupyterHub.ip = '0.0.0.0'
c.JupyterHub.port = 8000
c.Spawner.notebook_dir = '/python'

# Spawner settings
c.JupyterHub.spawner_class = 'jupyterhub.spawner.LocalProcessSpawner'

# Security settings
c.JupyterHub.log_level = 'DEBUG'
c.ConfigurableHTTPProxy.auth_token = secrets.token_hex(32)
c.JupyterHub.cookie_secret = secrets.token_bytes(32)

# Add these security-related settings for HTTPS
c.JupyterHub.cookie_options = {
    'secure': True,
    'httponly': True,
}