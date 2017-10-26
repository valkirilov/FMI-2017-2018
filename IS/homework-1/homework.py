
import math


class Board(object):
    def __init__(self, data, emptyElementIndex, size=None):
        if (size is None):
            self.data = data
            self.size = len(data)
            self.emptyElementIndex = emptyElementIndex
        else:
            self.data = [1]*size + [0] + [-1]*size
            self.size = size*2 + 1
            self.emptyElementIndex = math.floor(size)

    def print(self):
        print(self.data)

    def is_final(self):
        for x in range(0, self.size):
            if self.data[x] != -1 and x < math.floor(self.size/2):
                return False
            elif self.data[x] != 1 and x >= math.ceil(self.size/2):
                return False

        return True

    def find_moves(self, path=[], indent=''):
        currentPath = list(path)
        currentPath.append(self)

        movements = [(-1, 1), (-2, 2), (1, 1), (2, 2)]
        for move in movements:
            if (self.check_move(self.emptyElementIndex+move[0], move[1])):
                newBoard = self.make_move(self.emptyElementIndex+move[0])

                if find_path(newBoard, currentPath, indent+' '):
                    return

    def check_move(self, index, multiplier):
        if index < 0:
            return False
        if index >= self.size:
            return False

        if index + (self.data[index] * multiplier) != self.emptyElementIndex:
            return False

        return True

    def make_move(self, index):
        em_index = self.emptyElementIndex
        data = list(self.data)
        data[index], data[em_index] = data[em_index], data[index]
        return Board(data, index)

board = []
path = []


def print_path(path):
    for x in range(0, len(path)):
        path[x].print()


def find_path(board, path=[], indent=''):
    if board.is_final():
        print('Solution found')
        path.append(board)
        print_path(path)
        exit()
        return True

    board.find_moves(path, indent)


# board = Board(None, None, 2)
# board = Board(None, None, 3)
# board = Board(None, None, 4)
# board = Board(None, None, 5)
board = Board(None, None, 10)

find_path(board, [], '')
