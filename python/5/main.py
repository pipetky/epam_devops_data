def get_max(lst):
    ex_elems = []
    int_elems = []
    for elem in lst:
        if type(elem) is not int:
            ex_elems.append(elem)
        else:
            int_elems.append(elem)
    int_elems.sort()
    int_elems.reverse()
    print(f"You've passed some extra elements that I can't parse: {ex_elems}")

    return int_elems[:3]

if __name__ == '__main__':
    print(get_max([1, 250, 3, 5, 6, 7, 8, 9, 'dkfjg', 'dfg', 45, 'f456tf', 7890, '765234']))