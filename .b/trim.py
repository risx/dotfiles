#! /usr/bin/python2.7
#thank you https://github.com/lwander for this

import sys
import os

path = sys.stdin.readline()
path = path.strip()

home = os.path.expanduser('~')
if len(home) <= len(path) and path[:len(home)] == home:
    path = '~' + path[len(home):]

path = path.split('/')

for (i, v) in enumerate(path):
    if i > 0 and i < len(path) - 1 and len(v) > 0:
        path[i] = v[0]

sys.stdout.write('/'.join(path))