# SUPEREXPORT - a permanent vault export
Sick of exporting everytime again and again the secrets from vault? this is (hopefully) your solution

## USE at YOUR own RISK ! ! !

### Prerequiries 
For this service you need to have the following tools installed:   
`secret-tool` -> Some shells have it, some not. (just enter `secret-tool` and see if it works     
`vault` Info: [Vault CLI](https://www.vaultproject.io/docs/commands)   


### Prepare .bashrc / zshrc
before you start:  
add this to your `.bashrc`or `zshrc`

```bash
alias superexport="bash path/to/this/folder/superexport.sh"
```

also add this line to your `.bashrc`, so the `.secretreader.sh` is read with every new terminal
```bash
source /home/$USERNAME/.superexport/.secretreader.sh
```

### Run it

normally you would export your secrets like this:
```bash
export MY_KEY=$(vault kv get -field=name-in-vault "companyname/teamname/folder-with-secret")
```

with `superxport` you do it like this: 
```bash
superexport MY_KEY name-in-vault companyname/teamname/folder-with-secret a-prefix
``` 

to see that it worked, YOU HAVE TO OPEN A NEW TERMINAL (else it's not available)
```bash 
echo $MY_KEY
```

the idea came while I was using a script from a colleague at work - but I was sick of adding them manually to the script 

### Tip: If you run your IDE from your shell, you will have all the exported variables there 
