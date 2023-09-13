def pp(x):
    import json
    import sys
    json.dump(x, sys.stdout, sort_keys=True, indent=2)


try:
    import readline
except ImportError:
    pass
else:
    readline.set_history_length(10000)
