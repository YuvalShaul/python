#### How to Reset your local re
If you have changed your local repository (on your computer), and you want to 
restore things to the status it was when you first cloned the repository:
- To restore a single file:
```
git fetch
git checkout origin/main <filepath>
```
- To restore the whole repository:
```
git fetch
git reset --hard origin/main
```
