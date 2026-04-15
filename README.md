# CBC Soundbooth Automation Website
This repository stores a very simple Apache-based cgi-bin website that presents a set of default actions that can support soundbooth startup and shutdown with additional tasks to support project, camera and Crestron media switchers.
# Steps to image the Raspberry Pi 4 with Ubuntu 24.04 LTS
On another machine:
Download Raspberry Pi Imager: https://www.raspberrypi.com/software/

Choose:
```
OS → Ubuntu → Ubuntu Server 24.04 LTS (64‑bit)
Storage → your SD card or USB SSD
```
⚙️ Advanced settings (recommended)

- Set hostname - `cbc-pi`
- Enable SSH - `<password>`
- Create your primary user & password - `pi <phonenumber>`
- Configure Wi‑Fi (if you’ll need it headless)
- Leave everything else default
# Deployment model
Currently, the site is deployed to a local Raspberry Pi 4 running in the data closet at CBC.
It can be reached on the intranet @ http://cbc-pi.cbclocal
It is accessable anywhere on the CBC lan, and is supposed to be set as the default home page for Chrome on the Soundbooth PCs to aid in quick access.
# How to setup and install the system.
This setup is designed and tested on a pretty vanilla Ubuntu Server 24.04 running on a Raspberry Pi 4.
- clone the repository to a local directory name soundbooth (default).
- Install repository via bootstrap & install Apache
```
sudo apt-get install -qq -y git
git clone https://github.com/AlienShuffle/soundbooth.git
cd ~/soundbooth
./bootstrap.sh
./install-apache.sh
````
- Setup the soundbooth website (details are pretty clear in the .sh file)
```
./setup-cbc-site.sh
./restart-apache.sh
```
