# Taiga-Script-Docker
A docker taiga (https://taiga.io/) build based on taiga-script(https://github.com/taigaio/taiga-scripts) with no "so many containers I loose my mind" nonsense

I also tried to do a taiga build based on https://github.com/ipedrazas/taiga-docker but to no avail till now and since I am really more interested by "immutable deploy" 
than "zillion containers spinning around" stuff I decided to try to build taiga in a docker based on taiga-scripts.

The docker is based on the great phusion/baseimage-docker image that share and help with the "one app stack in a container mindset" (cf http://phusion.github.io/baseimage-docker/).

I tried **not** to fork the taiga-script project, to be able to go with the flow of its evolution.

So this is not a "stable build", meaning build results can change with the evolution of taiga-script and taiga itself.
Fork taiga script and modify setup-taiga.sh accordingly if you feel uncomfortable with that, but given that taiga (and taiga-scripts) is "in development" ... makes little sense)

That's also why we have some "sed .." changes in setup-taiga.sh

I also externaly (in my setup script setup-taiga) re-enabled the async support (through Redis and rabbitMQ).

TODO :
- allow to pass the hostname rather than have to edit setup-taiga.sh
- look to change that hostname only once rather than in multiple files
- allow to build a debug/non async container through "options" rather than manual edits
- add async events ?
- test more ;)





