#!/bin/bash

shards install

make sam db:migrate

crystal src/main.cr
