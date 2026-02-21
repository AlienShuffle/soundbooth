# CBC Soundbooth Automation Website
This repository stores a very simple Apache-based cgi-bin website that presents a set of default actions that can support soundbooth startup and shutdown with additional tasks to support project, camera and Crestron media switchers.
# Deployment model
Currently, the site is deployed to a local Raspberry Pi 4 running in the data closet at CBC.
It can be reached on the intranet @ http://cbc-pi.cbclocal
It is accessable anywhere on the CBC lan, and is supposed to be set as the default home page for Chrome on the Soundbooth PCs to aid in quick access.
# How to setup and install the system.
- This setup is designed and tested on a pretty vanilla Ubuntu Server 24.04 running on a Raspberry Pi 4.
- clone the repository to a local directory.
Install Apache
```
./install-apache.sh
````
- Setup the soundbooth website (details are pretty clear in the .sh file)
```
./setup-cbc-site.sh
```
