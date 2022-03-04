def chars_count(string):
    chars = {}
    for ch in string:
        try:
            chars[ch] += 1
        except KeyError:
            chars[ch] = 1
    return chars


if __name__ == '__main__':
    print(chars_count(
        'Python is a programming language that lets you work more quickly and integrate your systems more effectively.'))
