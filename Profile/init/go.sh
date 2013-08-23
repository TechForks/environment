#!/bin/zsh

if [[ -e "/usr/local/bin/go" ]] then
    export GOROOT="/usr/local/Cellar/go/1.1"
    export GOPATH="$SOURCE_DIR/gopath"
    export PATH="$PATH:$GOPATH/bin"
    alias goplay="go run /usr/local/Cellar/go/1.1/misc/goplay/goplay.go"
fi