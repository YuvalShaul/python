from traitlets.config import get_config
from jupyterhub.auth import DummyAuthenticator
from jupyterhub.spawner import LocalProcessSpawner
import secrets
import os

print('Loding this file!!!')
c = get_config()

class MyDummyAuthenticator(DummyAuthenticator):
    passwords = {
        'yuval': 'yuval',
        'john': 'john'
    }
    
    async def authenticate(self, handler, data):
        username = data['username']
        password = data['password']
        if username in self.passwords and password == self.passwords[username]:
            return username
        return None
    

# Authentication settings - put these first!
c.JupyterHub.authenticator_class = DummyAuthenticator
c.Authenticator.admin_users = {'yuval'}
names_dict = { "student" + str(num) for num in range(1, 31)}
names_dict.add('yuval')
c.Authenticator.allowed_users = names_dict


# Remove this line as it's for LocalAuthenticator
# c.LocalAuthenticator.create_system_users = True

# Basic Configuration
c.JupyterHub.ip = '0.0.0.0'
c.JupyterHub.port = 8000
c.Spawner.notebook_dir = '/analysis'

# Use DockerSpawner
# c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'
c.JupyterHub.spawner_class = 'jupyterhub.spawner.LocalProcessSpawner'

# c.DockerSpawner.image = os.environ['DOCKER_JUPYTER_IMAGE']
# c.DockerSpawner.network_name = 'jupyterhub-network'
# c.DockerSpawner.remove = True

# Debug and security
c.JupyterHub.log_level = 'DEBUG'
# c.JupyterHub.cookie_secret = bytes(32)
# c.ConfigurableHTTPProxy.auth_token = bytes(32)

c.ConfigurableHTTPProxy.auth_token = secrets.token_hex(32)
c.JupyterHub.cookie_secret = secrets.token_bytes(32)