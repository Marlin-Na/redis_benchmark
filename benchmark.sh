#!/usr/bin/env bash

trap "exit" INT TERM ERR
trap "kill 0" EXIT

## Start redis server in background
redis-server --port 8864 >/dev/null 2>/dev/null &

YCSB_BIN=./YCSB-master/bin/ycsb

function ycsb_load {
    $YCSB_BIN load load redis -s -p "redis.port=6379" -P "$@"
}
function ycsb_run {
    $YCSB_BIN run load redis -s -p "redis.port=6379" -P "$@"
}

echo ============ ycsb load =============
ycsb_load workloads/workloada
echo ============ ycsb run =============
ycsb_run workloads/workloada
