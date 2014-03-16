# Initially stollen from github.com/coderholic/config
# Most of these from http://sontek.net/tips-and-tricks-for-the-python-interpreter
import os
import sys

try:
    import readline
except ImportError:
    pass
else:
    import rlcompleter
    if 'libedit' in readline.__doc__:
        readline.parse_and_bind("bind ^I rl_complete")
    else:
        readline.parse_and_bind("tab: complete")

    # Enable a History
    HISTFILE="%s/.pyhistory" % os.environ["HOME"]

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
finally:
    del rlcompleter

WELCOME=''

# Enable Pretty Printing for stdout
def my_displayhook(value):
    if value is not None:
        try:
            import __builtin__
        except ImportError:
            pass

        __builtins__._ = value

        import pprint
        pprint.pprint(value)
        del pprint

sys.displayhook = my_displayhook
