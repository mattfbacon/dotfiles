set -l NUMCPUS (nproc)
alias make="time nice make -j"$NUMCPUS" --load-average="$NUMCPUS
