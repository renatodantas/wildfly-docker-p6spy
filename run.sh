#!/bin/bash
docker container rm dft-wildfly -v
docker run --name dft-wildfly -p 8080:8080 -p 9990:9990 -p 8787:8787 dft-wildfly