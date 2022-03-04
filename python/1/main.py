
if __name__ == '__main__':
    input_data = input("Please enter some comma-separated numbers: ")
    res_list = list(input_data.split(','))
    res_tuple = tuple(input_data.split(','))
    print(res_tuple)
    print(res_list)
