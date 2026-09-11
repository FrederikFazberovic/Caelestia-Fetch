# Fastfetch config for Caelestia Dots

Its fastfetch config for [Caelestia Dots](https://github.com/caelestia-dots/shell).  
Its dynamic and more configs coming soon!  
Inspired by some [Fastfetch examples](https://github.com/fastfetch-cli/fastfetch/tree/dev/presets/examples) (forgot their numbers).  

<details>
<summary><h2>Screenshots</h2></summary>  

### Big config
  
![big](/preview/screenshot.png) 

### Compare between dynamic and hot reload

![compare](/preview/comparason.png)
  
### Small config
  
![small](/preview/small.png)  
  
### Big dynamic  
  
![big dynamic](/preview/big-dynamic.png)

</details>

# Acknowledge
### Dynamic logos were made with help of Claude Code.

# Installation
Clone repo with
```
git clone https://github.com/FrederikFazberovic/Caelestia-Fetch.git
``` 
  
cd to Caelestia Fetch with
```
cd Caelestia-Fetch
```  
  
copy folder from Caelestia-Fetch to   ```~/.config/fastfetch ```  

### DO NOT COPY FILES FROM FOLDERS, COPY ENTIRE FOLDERS!!!  
### Read bellow for dynamic logos or hot reload logos

<details>
<summary><h2>Dynamic Logos</h2></summary> 

### When scheme is changed, it has small delay.
Install script for dynamic logos with
```
chmod +x ./install-dynamic-logo.sh
bash ./install-dynamic-logo.sh
```
To enable dynamic effect on certain logo run
```
~/.local/bin/fastfetch-logo-colorize "/path/to/fastfetch_logo" --mode half
```
Change /path/to with actual path and fastfetch_logo with logo, you want to use.  
  
There are 2 modes,
``` --mode half ``` and ``` --mode full ```.  
``` --mode half ``` makes it so only upper half of caelestia will dynamically change, ``` --mode full ``` makes it so whole logo changes color.  
``` --mode half ``` [preview](https://github.com/FrederikFazberovic/Caelestia-Fetch/blob/main/preview/big-dynamic.png).  
### Uninstalling 
Run 
```
chmod +x ./uninstall-dynamic-logo.sh
bash ./uninstall-dynamic-logo.sh
```

</details>

<details>
<summary><h2>Hot Reload Logos</h2></summary> 
 
### This works like fastfetch logos
To install, you just copy folder with ``hr`` on end to ```~/.config/fastfetch```.

</details>

# Logos
For those, who only want ASCII logos, its in [aditional folder](https://github.com/FrederikFazberovic/Caelestia-Fetch/tree/main/aditional).

### Screenshots of logos
They are [here](https://github.com/FrederikFazberovic/Caelestia-Fetch/tree/main/aditional/preview).
  
  
  
  
  
[something](https://youtu.be/dQw4w9WgXcQ?is=qySV_oJA_PuKJLYL)
