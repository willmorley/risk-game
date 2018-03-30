#!/bin/bash
cat BoardSetup.s > combined.s
echo "" >> combined.s
cat main.s >> combined.s
echo "" >> combined.s
cat HEX.s >> combined.s
