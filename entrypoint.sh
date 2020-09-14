#!/bin/sh

# set -e

red () { printf "\033[1;31m%s\033[0m" "$*"; }
yellow () { printf "\033[1;33m%s\033[0m" "$*"; }
pink () { printf "\033[1;35m%s\033[0m" "$*"; }
blue () { printf "\033[1;34m%s\033[0m" "$*"; }
green () { printf "\033[1;32m%s\033[0m" "$*"; }
drk_green () { printf "\033[0;32m%s\033[0m" "$*"; }
cyan () { printf "\033[0;36m%s\033[0m" "$*"; }
grey () { printf "\033[2;30m%s\033[0m" "$*"; }

main () {
    PATHS="${@:-/src}"

    echo "$(blue '###') python-checker: $(green 'Checking the following paths...')"
    for path in "$PATHS"; do
        echo "    $(blue '-') $path"
    done
    echo

    errs=0

    echo "$(blue '###') $(yellow 'flake8')"
    flake8 $PATHS
    errs=$(( $errs + $?  ))

    echo
    echo "$(blue '###') $(pink 'pydocstyle')"
    pydocstyle $PATHS
    errs=$(( $errs + $?  ))

    echo
    echo "$(blue '###') $(grey 'black')"
    black --check $PATHS
    errs=$(( $errs + $?  ))

    echo
    echo "$(blue '###') $(cyan 'bandit')"
    bandit -r $PATHS
    errs=$(( $errs + $?  ))

    echo
    if [ "$errs" != "0" ]; then
        echo "$(blue '###') python-checker: $(red 'Found errors, please fix them!')"
    else
        echo "$(blue '###') python-checker: $(green 'All checks successful!')"
    fi
    
    exit $errs
}

main "$@"
