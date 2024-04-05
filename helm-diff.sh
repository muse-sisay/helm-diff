#!/bin/bash

# TODO: Parse command line arguments 
# Arguments 
#  - commit to compare against
#  - helm parameters
# ./helm-diff main values.yaml d-west2-01.yaml

COMPARE_COMMIT="$1"
shift
HELM_ARGS="$@"

# check .helm-diff dir exists
if [[ ! -d ./.helm-diff ]];then 
    mkdir -p .helm-diff/current
fi

helm dependency update

# helm template helm-diff <arguments>
# check whether that command run sucessfully
helm template helm-diff --include-crds --output-dir ./.helm-diff/current $HELM_ARGS . > /dev/null
if [ $? -ne 0 ]; then
    exit 1
fi

git stash
echo "$COMPARE_COMMIT"

# helm template on $COMPARE_COMMIT
git checkout $COMPARE_COMMIT

helm dependency update
helm template helm-diff --include-crds --output-dir ./.helm-diff/previous $HELM_ARGS . > /dev/null
if [ $? -ne 0 ]; then
    exit 1
fi

# git reset --hard
# git clean -d -x
git switch - 
git stash pop

# dirdiff
vim -c "DirDiff .helm-diff/current .helm-diff/previous"

rm -rf ./.helm-diff