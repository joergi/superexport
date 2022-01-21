# superexport
sick of exporting everytime again and again the secrets from vault? this is (hopefully your solution)

before you start:  
add this to `.bashrc`:
```bash
alias superexport="bash path/to/this/folder/superexport.sh"
```

also add the `.secretreader.sh` to your `.bashrc`  
```bash
source /home/$USERNAME/.superexport/.secretreader.sh
```
you can get your username with `whoami` on the commandline


the idea came while I was using a script from a colleague at work - but I was sick of adding them manually to the script 
