class Board(object):
    def __init__(self, data, emptyElementIndex, size=None):
        if (size is None):
            self.data = data
            self.emptyElementIndex = emptyElementIndex
        else:
            self.data = []
            self.emptyElementIndex = math.floor(len(data)/2)

            for x in range(0, size):
                self.data.append(1)

            self.data.append(0)

            for x in range(0, size):
                self.data.append(-1)

    def find_moves(self):
        return 'todo'