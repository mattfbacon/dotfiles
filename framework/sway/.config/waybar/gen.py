import re, sys

i = ['light', 'dark'].index(sys.argv[1])
vars = {
	'TEXT_PRIMARY': ('#004d57', '#b1b9bf'),
	'BACKGROUND_PRIMARY': ('#fef8ec', '#1b2932'),
	'PALE_BASE_RGB': ('0, 0, 0', '255, 255, 255'),
}

raw = sys.stdin.read()
out = re.sub('%([A-Za-z_][A-Za-z0-9_]*)%', lambda m: vars[m.group(1)][i], raw)
print(out)
