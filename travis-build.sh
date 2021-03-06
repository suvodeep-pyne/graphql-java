#!/bin/bash
set -ev
BUILD_COMMAND="./gradlew assemble && ./gradlew check"
if [ "${TRAVIS_PULL_REQUEST}" = "false" ] && [ "${TRAVIS_BRANCH}" = "master" ]; then
    echo "Building on master"
    BUILD_COMMAND="./gradlew clean assemble && ./gradlew check && ./gradlew bintrayUpload -x check --info"
fi
docker run -it --rm -v `pwd .`:/build  -e BINTRAY_USER=$BINTRAY_USER -e BINTRAY_API_KEY=$BINTRAY_API_KEY -w /build openjdk:8u131-jdk bash -c "${BUILD_COMMAND}"
