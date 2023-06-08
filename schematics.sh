#!/bin/sh

Yosys (){
yosys -p "read -sv2005 src/*.v; hierarchy -top $1; proc; write_json $1.json"
netlistsvg $1.json -o $1.svg
}

Yosys "cpu"
Yosys "Datapath"
