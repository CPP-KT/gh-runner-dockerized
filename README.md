# Isolated Runners

Scripts and configs for isolated GitHub Action Runners.

## Motivation

By default, GitHub Action Runner runs directly on host system. It is unsecure and may
lead to some side effects (e.g. storing some files on the host).

We launch a new container for each workflow run, so runs are isolated from the host
environment and apart from each other. Moreover, we prepare some default environment
for each type of run to save some time on re-downloading the same tools each time.

## Installation

* Install [sysbox-runc](https://github.com/nestybox/sysbox).
* Fill `scripts/.env` with `GITHUB_PERSONAL_TOKEN` and `GITHUB_OWNER`
  ([example](https://github.com/PasseiDireto/gh-runner/blob/master/.env-example)).
* Build images with `./build.sh`
* Add `build.sh` run to cron (each 6 hours is fine). Otherwise GitHub would try
  to update outdated versions of runners by invoking upgrade tasks, upon completing of
  which the environment would be recreated, leading to loops.
* Run `scripts/create-runner.sh <image-tag>` as many times as you need.

## Acknowledgements

This repository is heavily based on [ct-itmo/gh-runner-dockerized](https://github.com/ct-itmo/gh-runner-dockerized).
