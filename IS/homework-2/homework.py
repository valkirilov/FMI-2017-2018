
boardStartExample1 = [
			[1, 2, 3],
			[4, 5, 6],
			[7, 8, 0]
		]

boardFinalExample1 = [
				[1, 2, 3],
				[4, 0, 5],
				[7, 8, 6]
			]


class Board(object):
	def __init__(self, data, emptyElementCoords):    
		self.data = data
		self.emptyElementCoords = emptyElementCoords

	def print(self):
		print(self.data)

	def pretty_print(self):
		for x in range(0, len(self.data)):
			print(self.data[x])

	def calculate_heuristic(self, final):
		return

	def check_move(self, coords):
		if coords[0] < 0 or coords[0] > len(self.data):
			return False
		if coords[1] < 0 or coords[1] > len(self.data):
			return False

		return True




def find_solution_path(board_start, board_finish, path, distance):
	if (check_is_final(board_start, board_finish)):
		print('Solution found')
		return

	movement_coords = [(0, -1), (1, 0), (0, 1), (-1, 0)]
	print('TODO: Search solution')


def check_is_final(board_start, board_finish):
	for x in range(0, len(board_start.data)):
		for y in range(0, len(board_start.data)):
			if board_start.data[x][y] != board_finish.data[x][y]:
				return False
	return True


path = []

boardStart = Board(boardStartExample1, [2, 3])
boardFinal = Board(boardFinalExample1, [1, 1])
boardStart.pretty_print()

find_solution_path(boardStart, boardFinal, path, 0)