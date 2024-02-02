def pp(x):
    import json
    import sys
    json.dump(x, sys.stdout, sort_keys=True, ensure_ascii=False, indent=2)

