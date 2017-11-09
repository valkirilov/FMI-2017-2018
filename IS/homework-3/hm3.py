
import random
import time

start_time = time.time()

n = 1000

# Queens orderred by rows with their positions by columns
# queens_positions = [2, 0, 3, 1]
queens_positions = [-1]*n

# Board with values for the number of attacks of every field
board = [x[:] for x in [[0] * n] * n]


def print_queens_board(queens):
    """
    Print a 2 dimencional board with "*" for queens and "_" for empty spaces
    """
    for row in range(0, n):
        if queens[row] == -1:
            print('_'*n)
        else:
            print(('_'*queens[row]) + '*' + ('_'*(n-queens[row]-1)))


def print_chess_board(board):
    """
    Print a 2 dimencional chess board with values for the number of attacks
    for every field. The queens are now shown if this function is used
    """
    for row in range(0, n):
        print(board[row])


def init_queens_board(queens_positions, board):
    """
    Init the board and place the queens on it
    """

    for i in range(0, n):
        position = get_board_row_cheapest_position(board, i)
        queens_positions[i] = position[1]
        board = calculate_board_weight(queens_positions, board, position)

    # print_queens_board(queens_positions)
    # print_chess_board(board)
    return queens_positions, board


def calculate_board_weight(queens, board, attack_position, leave_position=None):
    i = attack_position
    j = leave_position

    if j is not None:
        board = queen_leave_top_right(j[0], j[1], board)
        board = queen_leave_top_left(j[0], j[1], board)
        board = queen_leave_bottom_right(j[0], j[1], board)
        board = queen_leave_bottom_left(j[0], j[1], board)
        board = queen_leave_vertical(j[0], j[1], board)

    if queens[i[0]] is not -1:
        board = queen_attack_top_right(i[0], i[1], board)
        board = queen_attack_top_left(i[0], i[1], board)
        board = queen_attack_bottom_right(i[0], i[1], board)
        board = queen_attack_bottom_left(i[0], i[1], board)
        board = queen_attack_vertical(i[0], i[1], board)

    return board


def get_board_most_expensive_position(board):
    most_expensive_positions_by_rows = []
    for i in range(n):
        index, value = queens_positions[i], board[i][queens_positions[i]]
        most_expensive_positions_by_rows.append((value, (i, index))) # (value, (row, col))

    # Get random expensive position
    max_value = most_expensive_positions_by_rows[0][0]
    max_values = []
    for j in range(len(most_expensive_positions_by_rows)):
        if most_expensive_positions_by_rows[j][0] >= max_value:
            if max_value < most_expensive_positions_by_rows[j][0]:
                max_values = []

            max_value = most_expensive_positions_by_rows[j][0]
            max_values.append(most_expensive_positions_by_rows[j])

    most_expensive_position = random.randint(0, len(max_values)-1)

    return max_values[most_expensive_position]


def get_board_row_cheapest_position(board, row):
    row_without_queen = []

    for i in range(0, n):
        if (i is not queens_positions[row]):
            row_without_queen.append((board[row][i], i))

    # Get random cheapest position
    min_value = row_without_queen[0][0]
    min_values = []
    for j in range(len(row_without_queen)):
        if row_without_queen[j][0] <= min_value:
            if min_value > row_without_queen[j][0]:
                min_values = []

            min_value = row_without_queen[j][0]
            min_values.append(row_without_queen[j])

    cheapest_position = random.randint(0, len(min_values)-1)

    return (row, min_values[cheapest_position][1])


def make_move(queens_positions, board, old_position):
    new_position = get_board_row_cheapest_position(board, old_position[0])
    queens_positions[old_position[0]] = new_position[1]

    board = calculate_board_weight(queens_positions, board, new_position, old_position)
    return queens_positions, board


def check_is_final(queens_positions, board):
    for i in range(0, n):
        if board[i][queens_positions[i]] is not 0:
            return False
    return True


def find_solution(queens_positions, board):
    for i in range(0, 100):
        if check_is_final(queens_positions, board):
            print('Solution found at move ' + str(i))
            print_queens_board(queens_positions)
            print_chess_board(board)
            return True

        most_expensive_position = get_board_most_expensive_position(board)
        queens_positions, board = make_move(queens_positions, board, most_expensive_position[1])
    return False


# Attack functions which adds values to the board on the attacked positions
def queen_attack_top_right(row, queen_position, board):
    return queen_action_top_right(row, queen_position, board, +1)


def queen_attack_top_left(row, queen_position, board):
    return queen_action_top_left(row, queen_position, board, +1)


def queen_attack_bottom_right(row, queen_position, board):
    return queen_action_bottom_right(row, queen_position, board, +1)


def queen_attack_bottom_left(row, queen_position, board):
    return queen_action_bottom_left(row, queen_position, board, +1)


def queen_attack_vertical(row, queen_position, board):
    return queen_action_vertical(row, queen_position, board, +1)


# Leave functions which decrements the values where the queeen has attacked the board
def queen_leave_top_right(row, queen_position, board):
    return queen_action_top_right(row, queen_position, board, -1)


def queen_leave_top_left(row, queen_position, board):
    return queen_action_top_left(row, queen_position, board, -1)


def queen_leave_bottom_right(row, queen_position, board):
    return queen_action_bottom_right(row, queen_position, board, -1)


def queen_leave_bottom_left(row, queen_position, board):
    return queen_action_bottom_left(row, queen_position, board, -1)


def queen_leave_vertical(row, queen_position, board):
    return queen_action_vertical(row, queen_position, board, -1)


# Apply the board changes when the attack/leave helper functions are used
def queen_action_top_right(row, queen_position, board, action):
    col_offset = 1
    for i in range(row-1, -1, -1):
        if queen_position+col_offset < n:
            board[i][queen_position+col_offset] += action
            col_offset += 1
    return board


def queen_action_top_left(row, queen_position, board, action):
    col_offset = 1
    for i in range(row-1, -1, -1):
        if queen_position-col_offset >= 0:
            board[i][queen_position-col_offset] += action
            col_offset += 1
    return board


def queen_action_bottom_right(row, queen_position, board, action):
    col_offset = 1
    for i in range(row+1, n):
        if queen_position+col_offset < n:
            board[i][queen_position+col_offset] += action
            col_offset += 1
    return board


def queen_action_bottom_left(row, queen_position, board, action):
    col_offset = 1
    for i in range(row+1, n):
        if queen_position-col_offset >= 0:
            board[i][queen_position-col_offset] += action
            col_offset += 1
    return board


def queen_action_vertical(row, queen_position, board, action):
    for i in range(0, row):
        board[i][queen_position] += action

    for i in range(row+1, n):
        board[i][queen_position] += action

    return board

while True:

    # Queens orderred by rows with their positions by columns
    # queens_positions = [2, 0, 3, 1]
    queens_positions = [-1]*n

    # Board with values for the number of attacks of every field
    board = [x[:] for x in [[0] * n] * n]

    queens_positions, board = init_queens_board(queens_positions, board)

    if find_solution(queens_positions, board):
        print("--- %s seconds ---" % (time.time() - start_time))
        break
