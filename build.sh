#!/bin/bash

# Set path variables
BUILD_DIST_DIR=$PWD/$BUILD_BASE_DIR/build
NGINX_GIT_CLONE_PATH=$PWD/$BUILD_BASE_DIR/tmp/nginx
BROTLI_GIT_CLONE_PATH=$PWD/$BUILD_BASE_DIR/tmp/brotli

# Install dependencies
apt update && apt install -y jq git curl gnupg2 ca-certificates apt-utils autoconf automake build-essential git libcurl4-openssl-dev libgeoip-dev liblmdb-dev libpcre++-dev libtool libxml2-dev libyajl-dev pkgconf wget zlib1g-dev

# Set nginx variables - latest version and the source download url
nginx_download_uri=$(curl -s $NGINX_GIT_TAGS_URI | jq -r '.[0].tarball_url')
#- NGINX_RELEASE_VERSION=$(curl -s $${NGINX_GIT_TAGS_URI} | jq -r '.[0].name' | cut -d"-" -f2)
NGINX_RELEASE_VERSION=1.16.0

# Create required directories
mkdir -p $BUILD_BASE_DIR
mkdir -p $BUILD_DIST_DIR
mkdir -p $BROTLI_GIT_CLONE_PATH
mkdir -p $NGINX_GIT_CLONE_PATH

# Clone Brotli and build the module
git clone --single-branch --branch master $BROTLI_GIT_REPO_URI $BROTLI_GIT_CLONE_PATH
(cd $BROTLI_GIT_CLONE_PATH && git submodule init)
(cd $BROTLI_GIT_CLONE_PATH && git submodule update)
(cd $NGINX_GIT_CLONE_PATH && wget https://nginx.org/download/nginx-$NGINX_RELEASE_VERSION.tar.gz)
(cd $NGINX_GIT_CLONE_PATH && tar xzvf nginx-$NGINX_RELEASE_VERSION.tar.gz)
(cd $NGINX_GIT_CLONE_PATH/nginx-$NGINX_RELEASE_VERSION && ./configure --with-compat --add-dynamic-module=$BROTLI_GIT_CLONE_PATH)
(cd $NGINX_GIT_CLONE_PATH/nginx-$NGINX_RELEASE_VERSION && make modules) 

# Copy the .so module files to dist folder
cp $NGINX_GIT_CLONE_PATH/nginx-$NGINX_RELEASE_VERSION/objs/ngx_http_brotli_filter_module.so $BUILD_DIST_DIR
cp $NGINX_GIT_CLONE_PATH/nginx-$NGINX_RELEASE_VERSION/objs/ngx_http_brotli_static_module.so $BUILD_DIST_DIR

# Add additional info about nginx version and os version
echo $NGINX_RELEASE_VERSION > $BUILD_DIST_DIR/.nginx
echo $BUILD_OS_VERSION > $BUILD_DIST_DIR/.os