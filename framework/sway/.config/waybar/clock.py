import json
import sys
import subprocess
import re

def sh(*args: str) -> str:
	return subprocess.run(args, capture_output=True, check=True, encoding='utf-8').stdout.strip()

day = sh('date', '+%d')

d = {
	'text': sh('date', '+%Y-%m-%d %H:%M:%S'),
	'tooltip': re.sub(f'\\b{day}\\b', f'<span underline="low">{day}</span>', sh('cal', '-m')),
}

json.dump(d, sys.stdout)
