# SUPEREXPORT
sick of exporting everytime again and again the secrets from vault? this is (hopefully your solution)

## USE of YOUR own RISK

before you start:  
add this to `.bashrc`:
```bash
alias superexport="bash path/to/this/folder/superexport.sh"
```
you can now run it like:

```bash
superexporter EXPORTED_USERNME variable_from_vault company/path/to/vault/project/ some-variable-to-make-it-unique
```

to see that it worked, YOU HAVE TO OPEN A NEW TERMINAL
```bash 
echo $EXPORTED_USERNME
```

## WARNING:  
please be aware that this script will add some export lines to your `.bashrc`



the idea came while I was using a script from a colleague at work - but I was sick of adding them manually to the script 
