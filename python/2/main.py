
def print_list(some_list):
    if type(some_list) is list:
        for i in some_list:
            if i == 254:
                break
            elif i % 2 == 0:
                print(i)
    else:
        print("Arg must be a list!")

if __name__ == '__main__':
    print_list([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 254, 255])
