#!/bin/bash
#Compiling into .js files and running tests
coffee -c main_test.coffee ../main.coffee
../node_modules/.bin/test main_test.js --recursive
#Cleanup
rm ../main.js main_test.js
