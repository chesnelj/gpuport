#!/bin/bash

prefix=$(dirname $0)
prefix=$(dirname $prefix)
prefix=$(realpath $prefix)

cd $prefix

mkdir -p $prefix/.vim
mkdir -p $prefix/.cpanm
mkdir -p $prefix/.ssh
touch -a $prefix/.git-credentials
touch -a $prefix/.gitconfig

optsssl=""

if [ "x$SSL_CERT_FILE" != "x" ]
then
  optsssl="--bind $SSL_CERT_FILE --bind $SSL_CERT_DIR"
fi

exec \
singularity exec \
  --nv \
  --no-home \
  --env PS1='\[\033[7m\]\u@\h:\w\$ \[\033[0m\] ' \
  --pwd $prefix \
  --bind $prefix \
  --bind $prefix/.vim:$HOME/.vim \
  --bind $prefix/.cpanm:$HOME/.cpanm \
  --bind /scratch \
  $optsssl \
  --bind $HOME/.vimrc:$HOME/.vimrc:ro \
  --bind $HOME/.ssh:$HOME/.ssh:ro \
  --bind $HOME/.gitconfig:$HOME/.gitconfig:ro \
  --bind $HOME/.git-credentials:$HOME/.git-credentials:ro \
  -B /usr/bin/tar:/usr/bin/host_tar \
  $prefix/.singularity.sif bash --rcfile $prefix/scripts/bashrc
