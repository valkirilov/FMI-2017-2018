
import math


class Board(object):
    def __init__(self, data, emptyElementIndex, size=None):
        if (size is None):
            self.data = data
            self.size = len(data)
            self.emptyElementIndex = emptyElementIndex
        else:
            self.data = []
            self.size = size*2 + 1
            self.emptyElementIndex = math.floor(size)

            for x in range(0, size):
                self.data.append(1)

            self.data.append(0)

            for x in range(0, size):
                self.data.append(-1)

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
        #print(indent + str(self.data))

        currentPath = list(path)
        currentPath.append(self)
        
        if (self.check_move(self.emptyElementIndex-1, 1)):
            newBoard = self.make_move(self.emptyElementIndex-1)

            if find_path(newBoard, currentPath, indent+' '):
                return 

        if (self.check_move(self.emptyElementIndex-2, 2)):
            newBoard = self.make_move(self.emptyElementIndex-2)
            
            if find_path(newBoard, currentPath, indent+' '):
                return

        if (self.check_move(self.emptyElementIndex+1, 1)):
            newBoard = self.make_move(self.emptyElementIndex+1)
            
            if find_path(newBoard, currentPath, indent+' '):
                return

        if (self.check_move(self.emptyElementIndex+2, 2)):
            newBoard = self.make_move(self.emptyElementIndex+2)
            
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
        data = list(self.data)
        data[index], data[self.emptyElementIndex] = data[self.emptyElementIndex], data[index]
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


#board = Board(None, None, 2)
#board = Board(None, None, 3)
#board = Board(None, None, 4)
#board = Board(None, None, 5)
board = Board(None, None, 6)

find_path(board, [], '')
