from spiral_matrix import spiral_matrix


class SM(spiral_matrix.SpiralMatrix):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def _series_from_integers(self, start, step):
        '''
        Populate series with integer values to fill the matrix cells.
        Return the series list.
        '''

        max = self.max

        try:
            series = range(start - 1 + max * step, start - 1, -step)[:max]
        except IndexError:
            msg = f'start:{start}  step:{step}  max:{max}  end:{start + max * step}'
            raise AttributeError(msg)

        return series


def seq_gen(num):
    seq = list(range(1, num ** 2 + 1))
    for i in seq:
        yield i


def my_spiral_matrix(num):
    direction = 0

    row = num
    col = num
    matrix = []
    for i in range(num):
        matrix.append([])
    gen = seq_gen(num)
    for lst in matrix:
        for i in range(num):
            lst.append("_")
    r = c = 0

    for _ in range(row * col):
        matrix[r][c] = next(gen)
        if direction == 0:
            c += 1
            if c == col or matrix[r][c] != "_":
                direction = 1
                c -= 1
                r += 1

        elif direction == 1:
            r += 1
            if r == row or matrix[r][c] != "_":
                direction = 2
                r -= 1
                c -= 1

        elif direction == 2:
            c -= 1
            if c == -1 or matrix[r][c] != "_":
                direction = 3
                c += 1
                r -= 1

        elif direction == 3:
            r -= 1
            if matrix[r][c] != "_":
                direction = 0
                r += 1
                c += 1

    for row in matrix:
        row_4_print = ''
        for i in row:
            row_4_print += str(i) + " "
        print(row_4_print)


if __name__ == '__main__':
    matrix = SM(9, bearing='W')
    matrix.show()

    my_spiral_matrix(9)
