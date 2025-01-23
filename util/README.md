#### How to Reset your local re
If you have changed your local repository (on your computer), and you want to 
restore things to the status it was when you first cloned the repository:
- Run a terminal from jupyter-lab
- To restore a single file, type:
```
git fetch
git checkout origin/main <filepath>
```
- To restore the whole repository type:
```
git fetch
git reset --hard origin/main
```
