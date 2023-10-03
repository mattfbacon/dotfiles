import json
import sys
import subprocess

def sh(*args: str) -> str:
	return subprocess.run(args, capture_output=True, check=True, encoding='utf-8').stdout.strip()

d = {
	'text': sh('date', '+%Y-%m-%d %H:%M:%S'),
	'tooltip': sh('cal', '-m'),
}

json.dump(d, sys.stdout)
