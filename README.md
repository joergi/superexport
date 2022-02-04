# SUPEREXPORT - a permanent vault export
Sick of exporting everytime again and again the secrets from vault? this is (hopefully) your solution

## USE at YOUR own RISK ! ! !

before you start:  
add this to your `.bashrc`:

```bash
alias superexport="bash path/to/this/folder/superexport.sh"
```
you can now run it like:


also add the this line to your `.bashrc`, so the `.secretreader.sh` is read with every new terminal
```bash
source /home/$USERNAME/.superexport/.secretreader.sh
```

to see that it worked, YOU HAVE TO OPEN A NEW TERMINAL
```bash 
echo $EXPORTED_USERNME
```

the idea came while I was using a script from a colleague at work - but I was sick of adding them manually to the script 
