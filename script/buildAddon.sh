#!/usr/bin/env bash

commit=8c7c0828f482018dbba5e13a6a7d1e4b2773d868

rDIR=$(pwd)
rnd=$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 13 ; echo)
tmpDir=/tmp/$rnd

echo "${tmpDir}"


cd $tmpDir

git clone -b normalize-funcname-error --single-branch https://github.com/yosiat/libpg_query.git
cd libpg_query


# echo "git checkout to $commit"
git checkout $commit


if [ "$(uname)" == "Darwin" ]; then
	make CFLAGS='-mmacosx-version-min=10.7' PG_CFLAGS='-mmacosx-version-min=10.7'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	make CFLAGS='' PG_CFLAGS=''
fi

if [ $? -ne 0 ]; then
	echo "ERROR: 'make' command failed";
	exit 1;
fi

wDIR=$(pwd)

file=$(ls | grep 'libpg_query.a')

if [ ! $file ]; then
	echo "ERROR: libpg_query.a not found";
	exit 1;
fi

file=$(ls | grep 'pg_query.h')

if [ ! $file ]; then
	echo "ERROR: pg_query.h not found";
	exit 1;
fi

#copy queryparser.cc, binding.gyp to current directory
#
#

if [ "$(uname)" == "Darwin" ]; then
    cp $(pwd)/libpg_query.a $rDIR/libpg_query/osx/
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    cp $(pwd)/libpg_query.a $rDIR/libpg_query/linux/
fi

cp $(pwd)/pg_query.h $rDIR/libpg_query/include/

cd $rDIR && rm -rf $wDIR
