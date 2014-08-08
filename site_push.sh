#!/usr/bin/env bash
#
export S3_BUCKET="disruptivebias.com"
export TEMP_DEPLOY_DIR="/tmp/${S3_BUCKET}"
export S3CMD_CFG="$(pwd)/.s3cfg"
export JEKYLL_CMD="/usr/local/Cellar/ruby/2.1.1/bin/jekyll"

rm -rf ${TEMP_DEPLOY_DIR}

mkdir -p ${TEMP_DEPLOY_DIR}

git clone $(pwd) ${TEMP_DEPLOY_DIR}
pushd ${TEMP_DEPLOY_DIR}
git submodule update --init --recursive
${JEKYLL_CMD} build
/usr/bin/env s3cmd -c ${S3CMD_CFG} sync --delete-removed --acl-public --exclude '.git*' --exclude '.s3cfg' --exclude 'site_push.sh' _site/ s3://${S3_BUCKET}

popd
