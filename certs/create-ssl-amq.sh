#!/bin/bash

echo "Generate a self-signed certificate for the broker keystore:"
echo "-----------------------------------------------------------"
echo "keytool -genkey -alias broker -keyalg RSA -keystore broker.ks"
keytool -genkey -alias broker -keyalg RSA -keystore broker.ks
echo
echo

echo "Export the certificate so that it can be shared with clients:"
echo "-----------------------------------------------------------"
echo "keytool -export -alias broker -keystore broker.ks -file broker_cert"
keytool -export -alias broker -keystore broker.ks -file broker_cert
echo
echo

echo "Generate a self-signed certificate for the client keystore::"
echo "-----------------------------------------------------------"
echo "keytool -genkey -alias client -keyalg RSA -keystore client.ks"
keytool -genkey -alias client -keyalg RSA -keystore client.ks


echo "Create a client truststore that imports the broker certificate:"
echo "-----------------------------------------------------------"
echo "keytool -import -alias broker -keystore client.ts -file broker_cert"
keytool -import -alias broker -keystore client.ts -file broker_cert

echo "Export the client’s certificate from the keystore:"
echo "-----------------------------------------------------------"
echo "keytool -export -alias client -keystore client.ks -file client_cert"
keytool -export -alias client -keystore client.ks -file client_cert

echo "Import the client’s exported certificate into a broker SERVER truststore:"
echo "-----------------------------------------------------------"
echo "keytool -import -alias client -keystore broker.ts -file client_cert"
keytool -import -alias client -keystore broker.ts -file client_cert
