# Initially stollen from github.com/coderholic/config
# Most of these from http://sontek.net/blog/old/tips_and_tricks_for_the_python_interpreter

def pp(x):
    import json
    import sys
    json.dump(x, sys.stdout, sort_keys=True, indent=2)


try:
    import readline
except ImportError:
    pass
else:
    import rlcompleter
    is_libedit = 'libedit' in readline.__doc__
    if is_libedit:
        readline.parse_and_bind("bind ^I rl_complete")
    else:
        readline.parse_and_bind("tab: complete")

    # Enable a history
    from os import environ
    HISTFILE="%s/.pyhistory" % environ["HOME"]

    # Read the existing history if there is one
    try:
        readline.read_history_file(HISTFILE)
    except:
        pass

    # Set maximum number of items that will be written to the history file
    readline.set_history_length(500)

    def savehist():
        import readline
        global HISTFILE
        readline.write_history_file(HISTFILE)

    import atexit
    atexit.register(savehist)
    del atexit
    del environ
finally:
    del rlcompleter

