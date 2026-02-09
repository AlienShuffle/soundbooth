#!/usr/bin/env bash
sudo apt update
sudo apt install apache2
sudo a2enmod cgi
sudo systemctl restart apache2
