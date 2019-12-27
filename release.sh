#!/bin/sh

dirs=`ls -1d *`

for d in $dirs; do
	if [ -d "$d" ]; then
		(
			cd $d/build || continue
			
			#Get nginx and OS versions, tag
			NGINX_RELEASE_VERSION=`cat .nginx`
			OS_RELEASE_VERSION=`cat .os`
			GIT_TAG=$NGINX_RELEASE_VERSION-$OS_RELEASE_VERSION

			# Tag and release
			git init
			git remote add origin $BROTLI_MODULE_GIT_REPOSITORY
			git checkout -b build-$GIT_TAG
			git add --all
			git commit -m 'Brotli Module for nginx v$NGINX_RELEASE_VERSION ($OS_RELEASE_VERSION)'
			git push origin build-$GIT_TAG
			git tag -am "Brotli module built for nginx v$NGINX_RELEASE_VERSION ($OS_RELEASE_VERSION)" $GIT_TAG && git push origin $GIT_TAG
			git push origin --delete build-$GIT_TAG
		)
	fi
done