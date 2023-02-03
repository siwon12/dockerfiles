#!/bin/sh

ngrok authtoken $NGROK_AUTH
ngrok $NGROK_PROTOCOL $HOST_PORT