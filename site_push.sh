#!/usr/bin/env bash
#
unset GIT_DIR
unset GIT_WORK_TREE
export S3_BUCKET="disruptivebias"
export TEMP_DEPLOY_DIR="/tmp/${S3_BUCKET}"
export GIT_DIR=$(pwd)
export GIT_WORK_TREE=${TEMP_DEPLOY_DIR}
export S3CMD_CFG="${GIT_DIR}/.s3cfg"
export JEKYLL_CMD="/usr/local/Cellar/ruby/2.1.1/bin/jekyll"

rm -rf ${TEMP_DEPLOY_DIR}

mkdir -p ${TEMP_DEPLOY_DIR}
git checkout -f
pushd ${TEMP_DEPLOY_DIR}

${JEKYLL_CMD} build
/usr/bin/env s3cmd -c ${S3CMD_CFG} sync --delete-removed --acl-public --exclude '.git*' --exclude '.s3cfg' _site/ s3://${S3_BUCKET}

popd
