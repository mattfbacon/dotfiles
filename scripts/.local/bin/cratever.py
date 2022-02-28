#!/usr/bin/env python3

import requests
import sys
import re

crate = sys.argv[1]
data = requests.get(f'https://crates.io/api/v1/crates/{crate}').json()

max_version = data['crate']['max_version']
max_stable = data['crate']['max_stable_version'] or max_version

def process(raw):
    DELIM = '.'
    split = re.split(r'\.|-', raw)
    if any(x in ['rc', 'alpha', 'beta'] for x in split):
        return raw
    n_keep = 0
    while split[n_keep] == '0':
        n_keep = n_keep + 1
    return DELIM.join(split[0:n_keep + 1])

print(process(max_version))
print(process(max_stable))
