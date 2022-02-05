#!/bin/sh

VERSION=1.0.0

while getopts v:h: flag
do
    case "${flag}" in
        v) VERSION=${OPTARG};;
    esac
done

sudo -v && sudo="true" || sudo=""

if ! [[ -x "$(command -v danger)" ]]; then
	if ! [[ -x "$(command -v npm)" ]]; then
		echo "Please install node js"
		exit 1
	fi

	echo "Installing danger"

	if [[ -n "$sudo" ]]; then
		sudo npm install -g danger
	else
		npm install -g danger
	fi
fi

if [[ -n "$sudo" && "$OSTYPE" != "darwin"* ]]; then
	sudo chmod -R a+rwx /usr/local/
fi

git clone https://github.com/hbmartin/kotlin.git --depth 1 _danger-kotlin
cd _danger-kotlin && make install
cd ..
rm -rf _danger-kotlin
