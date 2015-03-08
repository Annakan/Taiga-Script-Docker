# Taiga-Script-Docker
A docker taiga (https://taiga.io/) build based on taiga-script(https://github.com/taigaio/taiga-scripts) with no "so many containers I loose my mind" nonsense

I also tried to do a taiga build based on https://github.com/ipedrazas/taiga-docker but to no success till now and since I am really more interrested by "immutable deploy" 
than "zillion containers spinning around" stuff I decided to try to build taiga in a docker based on taiga-scripts.

The docker is based on the great phusion/baseimage-docker image that share and help with the "one app stack in a container vision" (cf http://phusion.github.io/baseimage-docker/).

I tried to **not** fork the taiga-script project to be able to go with the flow of its evolution, so this is not 
a "stable build", meaning it can change in results with the evolutions of taiga-script (Fork taiga script and modify setup-taiga.sh accordingly
if you feel uncomfortable with that, but given that taiga is "in development" ... makes little sense)
That's why we have some "sed .." changes in setup-taiga.sh

I also externaly (in my setup script setup-taiga) re-enabled the async support (throug redis and rabbitMQ).

TODO :

- allow to pass the hostname rather than have to edit setup-taiga.sh
- look to change that hostname only once rather than in multiple files
- allow to build a debug/non async container through "options" rather than manual edits
- test more ;)





