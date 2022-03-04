import sys

if __name__ == '__main__':
    while input("Please enter some words: ") not in sys.argv:
        print("doesn't match")
    print('terminate!')
