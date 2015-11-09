#!/bin/bash
set -x
# Get a new esxi build from user upload or a url

cd /builds/esxi/

if [ -n "$build_url" ]; then
  echo "Using URL"
  build_number=${build_url:0-18:7}
  if [ ! -d "$build_number" ]; then
    mkdir $build_number
  fi
  cd $build_number
  wget -nv $build_url
  build_filename=${build_url##*/}
  echo "build number: ${build_number}"

else
  echo "Using uploaded file."
  build_number=${build_iso_file:0-18:7}
  if [ ! -d "$build_number" ]; then
    mkdir $build_number
  fi
  cd $build_number
  mv ${WORKSPACE}/build_iso_file ${build_iso_file}
  echo "build number: ${build_number}"
  build_filename=${build_iso_file}

fi

echo "Extracting iso."
../scripts/extract_iso.sh $build_filename

#TODO: add build to Jenkins job