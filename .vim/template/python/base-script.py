#!/usr/bin/env python3

def main():
    import argparse
    parser = argparse.ArgumentParser()

    parser.add_argument("--{{_cursor_}}")
    
    args = parser.parse_args()


if __name__ == "__main__":
    main()
