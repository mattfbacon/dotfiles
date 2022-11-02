complete -c emon -d 'Enable or disable external monitors'
set -l subcommands on off
complete -f -c emon -n "not __fish_seen_subcommand_from $subcommands" -a off -d 'Disable other monitors'
complete -f -c emon -n "not __fish_seen_subcommand_from $subcommands" -a on -d 'Enable other monitors'
