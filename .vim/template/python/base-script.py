#!/usr/bin/env python3

import logging
from logging.config import fileConfig
from os.path import expanduser

home = expanduser("~")

fileConfig(fname=f'{home}/Repositories/dotfiles/logging.conf',
        disable_existing_loggers=False)
logger = logging.getLogger(__name__)

from MyLibrary.utils import set_loglevel


def main():
    import argparse
    parser = argparse.ArgumentParser(description="")

    parser.add_argument("--verbose", "-v", action="count", default=0)
    parser.add_argument("--silent", "-s", action="count", default=0)
    parser.add_argument("--{{_cursor_}}")
    
    args = parser.parse_args()

    set_loglevel(modules=[__name__], verbose=args.verbose, silent=args.silent)


if __name__ == "__main__":
    main()
