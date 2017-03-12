alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

alias g="./gradlew"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
