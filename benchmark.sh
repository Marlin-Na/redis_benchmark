#!/usr/bin/env bash

trap "exit" INT TERM ERR
trap "kill 0" EXIT

## Start redis server in background
redis-server --port 8864 >/dev/null 2>/dev/null &

YCSB_BIN=./ycsb-redis-binding-0.17.0/bin/ycsb.sh

function ycsb_load {
    $YCSB_BIN load redis -s -p "redis.port=8864" -P "$@"
}
function ycsb_run {
    $YCSB_BIN run redis -s -p "redis.port=8864" -P "$@"
}

echo ============ ycsb load =============
ycsb_load workloads/workloada
echo ============ ycsb run =============
ycsb_run workloads/workloada
