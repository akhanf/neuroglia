#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi


DEST=$1
mkdir -p $DEST

D_DIR=$DEST/QAtools_v1.2
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi

echo -n "installing QA tools V1.2 ..." #-n without newline
QATOOLS_DIR=$D_DIR

curl -L --retry 5 https://www.dropbox.com/s/fsxnx6w4sbb4l1y/QAtools_v1.2.tar.gz?dl=0  >$DEST/QAtools_v1.2.tar.gz


cd $DEST
tar -xvzf QAtools_v1.2.tar.gz
rm QAtools_v1.2.tar.gz
cd 
#need to set QA_TOOLS as $QATOOLS_DIR


PROFILE=~/.bashrc

if grep -xq "PATH=$QATOOLS_DIR:\$PATH" $PROFILE #return 0 if exist
then 
 	echo "PATH=$QATOOLS_DIR" in the PATH already.
else
 	echo "export QA_TOOLS=$QATOOLS_DIR" >> $PROFILE
 	echo "export PATH=$QATOOLS_DIR:\$PATH" >> $PROFILE
fi

source $PROFILE
