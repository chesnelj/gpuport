#!/bin/bash
# use host system tar since container one can be blocked by security configuration
custom_tar="/usr/bin/host_tar"
tmp_dir=$(mktemp -d)
ln -s "$custom_tar" "$tmp_dir/tar"
export PATH="$tmp_dir:$PATH"
export TMP_TAR_DIR="$tmp_dir"





