#!/bin/bash

docker run -ti -v miktex:/var/lib/miktex -v `pwd`:/miktex/work  miktex/miktex:essential /bin/bash
