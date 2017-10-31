
import collections
import math
import copy
import heapq

try:
    import Queue as Q  # ver. < 3.0
except ImportError:
    import queue as Q

boardStartExample21 = [
      0, 1,
      3, 2
    ]
boardStartExample31 = [
      1, 2, 3,
      4, 5, 6,
      7, 8, 0
    ]
boardStartExample32 = [
      1, 2, 3,
      4, 0, 5,
      7, 8, 6
    ]
boardStartExample33 = [
      0, 1, 3,
      7, 2, 5,
      8, 4, 6
    ]
boardStartExample34 = [
      1, 2, 0,
      7, 4, 3,
      5, 8, 6
    ]
boardStartExample35 = [
      2, 4, 3,
      1, 6, 8,
      7, 5, 0
    ]
boardStartExample36 = [
      2, 3, 6,
      1, 0, 5,
      4, 7, 8
    ]
boardStartExample37 = [
      1, 2, 3,
      6, 0, 8,
      4, 7, 5
    ]
boardStartExample41 = [
      1, 6, 2, 4,
      9, 5, 3, 8,
      10, 14, 7, 11,
      13, 15, 12, 0
    ]
boardStartExample42 = [
      0, 2, 3, 4,
      1, 6, 7, 8,
      5, 10, 11, 12,
      9, 13, 14, 15
    ]
boardStartExample51 = [
      2, 3, 4, 5, 0,
      1, 7, 8, 9, 10,
      6, 12, 13, 14, 15,
      11, 17, 18, 19, 20,
      16, 21, 22, 23, 24
    ]


boardFinalExample2 = [
      1, 2,
      3, 0
    ]

boardFinalExample3 = [
      1, 2, 3,
      4, 5, 6,
      7, 8, 0
    ]
boardFinalExample32 = [
      1, 2, 3,
      4, 0, 5,
      7, 8, 6
    ]

boardFinalExample4 = [
      1, 2, 3, 4,
      5, 6, 7, 8,
      9, 10, 11, 12,
      13, 14, 15, 0
    ]

boardFinalExample5 = [
      1, 2, 3, 4, 5,
      6, 7, 8, 9, 10,
      11, 12, 13, 14, 15,
      16, 17, 18, 19, 20,
      21, 22, 23, 24, 0
    ]


class Board(object):
    def __init__(self, data, distance, depth=0):
        self.dimension = int(math.sqrt(len(data)))
        self.data = data
        self.orderedData = {}
        self.emptyElementCoords = None
        self.distance = distance
        self.depth = depth
        self.path = []

        for row in range(0, self.dimension):
            for col in range(0, self.dimension):
                self.orderedData[data[row*self.dimension + col]] = [row, col]

        self.emptyElementCoords = self.orderedData[0]

    def __lt__(self, rhs):
        if self.distance == rhs.distance:
            return self.depth > rhs.depth
        return self.distance < rhs.distance

    def print(self):
        print(self.data)

    def pretty_print(self):
        line = ''
        for x in range(0, len(self.data)):
            line += str(self.data[x]) + ' '
            if ((x+1) % self.dimension == 0):
                print(line)
                line = ''
        print('------')

    def calculate_heuristic(self, final):
        distance = 0

        for i in range(0, len(self.data)):
            row = int(i / self.dimension)
            col = i % self.dimension

            # Destination row/col
            dRow = final.orderedData[self.data[i]][0]
            dCol = final.orderedData[self.data[i]][1]

            difference = math.fabs(row - dRow) + math.fabs(col - dCol)
            distance += difference

        return distance

    def check_move(self, coords):
        eec = self.emptyElementCoords

        if (eec[0] + coords[0]) < 0 or (eec[0] + coords[0]) > self.dimension-1:
            return False
        if (eec[1] + coords[1]) < 0 or (eec[1] + coords[1]) > self.dimension-1:
            return False

        return True

    def make_move(self, coords):
        # print('Making the move')
        eec = self.emptyElementCoords
        oldValueCoords = (eec[0]*self.dimension + coords[0]*self.dimension) + (eec[1] + coords[1])
        value = self.data[oldValueCoords]

        # Swap the position of the items in the main list
        self.data[eec[0]*self.dimension + eec[1]] = value
        self.data[oldValueCoords] = 0

        # Set the new empty position
        self.emptyElementCoords = [eec[0] + coords[0], eec[1] + coords[1]]

        # Swap the values in the ordered list
        self.orderedData[value], self.orderedData[0] = self.orderedData[0], self.orderedData[value]


def find_solution_path(board_start, board_finish, path, queue, distance):

    print('New search')
    # input("Press Enter to continue...")
    board_start.pretty_print()
    print()
    visited.append(board_start)
    board_start.path.append(board_start)

    if (check_is_final(board_start, board_finish)):
        print('Solution found')
        board_start.pretty_print()
        print_path(board_start.path)
        exit()

    movement_coords = [[-1, 0, 'up'], [0, 1, 'right'], [1, 0, 'down'], [0, -1, 'left']]
    for move in movement_coords:
        if (board_start.check_move(move)):
            new_board = make_move(board_start, move)

            # Check is that board already visited
            if check_is_visited(new_board) is False:
                new_board.distance = new_board.calculate_heuristic(board_finish)
                new_board.path = list(board_start.path)
                print('Move ' + move[2] + '; Add to queue: distance: ' + str(new_board.distance) + '; depth: ' + str(new_board.depth))
                new_board.pretty_print()
                queue.put(new_board)

    while not queue.empty():
        next_board = queue.get()
        print('Get next board from the queue: distance: ' + str(next_board.distance) + '; depth: ' + str(next_board.depth))
        next_board.pretty_print()

        find_solution_path(next_board, board_finish, path, queue, next_board.distance)


def check_is_final(board_start, board_finish):
    return board_start.data == board_finish.data


def check_is_visited(board):
    for visited_board in visited:
        if visited_board.data == board.data:
            return True
    return False


def print_path(path):
    print()
    print('------------')
    print('Solution Path: ' + str(len(path) - 1) + ' moves')
    print('------------')

    for board in path:
        board.pretty_print()

    print('------------')
    print()


def make_move(board, move):
    board_data = list(board.data)
    board_distance = int(board.distance)
    board_depth = int(board.depth) + 1

    new_board = Board(board_data, board_distance, board_depth)
    new_board.make_move(move)
    return new_board

path = []
visited = []
priority_queue = Q.PriorityQueue()

boardStart = Board(boardStartExample33, 0)
boardFinal = Board(boardFinalExample3, 0)
print('Start')
boardStart.pretty_print()
print('Final')
boardFinal.pretty_print()
print()

find_solution_path(boardStart, boardFinal, path, priority_queue, 0)