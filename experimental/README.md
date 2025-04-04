# Experimental runner

Sometimes useful to make significant changes to runner. In order to separate testing from production runners this one needed.

Unlike other runners, this should be built by hand and killed after testing session.

Basically, workflow is:
```console
$ experimental/build.sh <compiler>
$ scripts/create-runner.sh <compiler>-exp gh-runner-ubuntu-exp
$ # do some testing and kill runner via screen
```
