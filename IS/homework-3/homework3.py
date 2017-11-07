
import random
import copy

n = 4

# Queens orderred by rows with their positions by columns
queens_positions = [x[:] for x in [[-1] * n] * n]

# Board with values for the number of attacks of every field
board = [x[:] for x in [[0] * n] * n]
last_move = None
history = []


def print_queens_board(queens):
    """
    Print a 2 dimencional board with "*" for queens and "_" for empty spaces
    """
    for row in range(n):
        print('_'.join(queens[row]))


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

    for i in range(n):
        print('Position ' + str(i) + 'th queen')
        position, value = get_board_row_cheapest_position(board, i)
        #position = random.randint(0, n-1)
        queens_positions[i] = ['']*n
        queens_positions[i][position[1]] = '*'
        #print(queens_positions)
        # print(' Cheapest posotion is at: ' + str(position))
        #print_queens_board(queens_positions)
        board = calculate_board_weight(queens_positions, board, (i, position))

    return queens_positions, board


def calculate_board_weight(queens, board, attack_position, leave_position=None):
    #print_chess_board(board)
    i = attack_position[1]
    j = leave_position

    #print('Calculate chess board')
    #print_chess_board(board)
    if j is not None:
        #print('Leave queen from position ' + str(j))
        board = queen_leave_top_right(j, board)
        board = queen_leave_top_left(j, board)
        board = queen_leave_bottom_right(j, board)
        board = queen_leave_bottom_left(j, board)
        board = queen_leave_horizontal(j, board)
        board = queen_leave_vertical(j, board)
        #print()
        #print_chess_board(board)


    if queens[i[0]][i[1]] is not -1:
        #print('Move queen and attck to position ' + str(i))
        board = queen_attack_top_right(i, board)
        board = queen_attack_top_left(i, board)
        board = queen_attack_bottom_right(i, board)
        board = queen_attack_bottom_left(i, board)
        board = queen_attack_horizontal(i, board)
        board = queen_attack_vertical(i, board)
        #print()
        #print_chess_board(board)

    return board


def get_board_cheapest_position(board):
    cheapest_positions_by_rows = []
    for i in range(0, n):
        position, value = get_board_row_cheapest_position(board, i)
        cheapest_positions_by_rows.append((value, position)) # (value, (row, col))

    #_chess_board(board)
    #print('Cheapest positions by rows: (value, (row, col))')
    #print(cheapest_positions_by_rows)

    cheapest_position = min(cheapest_positions_by_rows)
    #print('The cheapest position is: ' + str(cheapest_position))
    return cheapest_position


def get_board_most_expensive_position(board, history):
    most_expensive_positions_by_rows = []
    for i in range(n):
        position, value = get_board_row_most_expensive_position(board, i, history)
        most_expensive_positions_by_rows.append((value, position)) # (value, (row, col))

    #print_chess_board(board)
    #print('Most expensive positions by rows: (value, (row, col))')
    #print(most_expensive_positions_by_rows)

    while len(most_expensive_position):
        most_expensive_position = max(most_expensive_positions_by_rows)

        if simulate_move(most_expensive_position, history):
            return most_expensive_position

    #print('The most expensive position is: ' + str(most_expensive_position))
    return None


def get_board_row_cheapest_position(board, row):
    row_without_queen = []

    for i in range(n):
        for j in range(n):
            if (queens_positions[i][j] is not '*'):
                row_without_queen.append((board[i][j], (i, j)))

    cheapest_position = min(row_without_queen)
    #print(row_without_queen)
    #print('Minimum value of ' + str(cheapest_position[0]) + ' found on position ' + str(cheapest_position[1]))
    return cheapest_position[1], cheapest_position[0]


def get_board_row_most_expensive_position(board, row, history):
    row_with_queens = []

    for i in range(n):
        for j in range(n):
            if (queens_positions[i][j] == '*'):
                row_with_queens.append((board[i][j], (i, j)))

    most_expensive_position = max(row_with_queens)
    # print('Maximum value of ' + str(cheapest_position[1]) + ' found on position ' + str(cheapest_position[0]))
    # print(row_with_queen)
    return most_expensive_position[1], most_expensive_position[0]


def make_move(queens_positions, board, old_position, history):
    #print('Most expensive position is ' + str(old_position))
    #old_position = (new_position[2], queens_positions[new_position[2]])
    #old_position = (new_position[2], queens_positions[new_position[2]])

    new_position = get_board_cheapest_position(board)

    queens_positions[old_position[0]][old_position[1]] = ''
    queens_positions[new_position[1][0]][new_position[1][1]] = '*'

    history.push(queens_positions)

    print()
    print_queens_board(queens_positions)

    #print('hererere')
    #print(new_position)
    board = calculate_board_weight(queens_positions, board, new_position, old_position)
    return queens_positions, board, last_move


def simulate_move(most_expensive_position, history):
    def is_in_history(queens, history, new_position, old_position):
        for hb in history:
            if hb == queens:
                return True
        retrun False


    queens = copy.deepcopy(queens_positions)
    return is_in_history(queens, history)


def check_is_final(queens_positions, board):
    for i in range(n):
        for j in range(n):
            if queens_positions[i][j] == '*' and board[i][j] is not 0:
                return False
    return True


def find_solution(queens_positions, board, history):
    if check_is_final(queens_positions, board):
        print('Solution found')
        print_queens_board(queens_positions)
        print_chess_board(board)
        exit()

    for i in range(0, 100):
        print('Searching for solution. Attempt #' + str(i))
        input("Press Enter to continue...")
        #print_queens_board(queens_positions)
        #cheapest_position = get_board_cheapest_position(board)
        most_expensive_position = get_board_most_expensive_position(board, history)
        queens_positions, board, history = make_move(queens_positions, board, most_expensive_position[1], history)


# Attack functions which adds values to the board on the attacked positions
def queen_attack_top_right(queen_position, board):
    return queen_action_top_right(queen_position, board, +1)


def queen_attack_top_left(queen_position, board):
    return queen_action_top_left(queen_position, board, +1)


def queen_attack_bottom_right(queen_position, board):
    return queen_action_bottom_right(queen_position, board, +1)


def queen_attack_bottom_left(queen_position, board):
    return queen_action_bottom_left(queen_position, board, +1)


def queen_attack_horizontal(queen_position, board):
    return queen_action_horizontal(queen_position, board, +1)


def queen_attack_vertical(queen_position, board):
    return queen_action_vertical(queen_position, board, +1)


# Leave functions which decrements the values where the queeen has attacked the board
def queen_leave_top_right(queen_position, board):
    return queen_action_top_right(queen_position, board, -1)


def queen_leave_top_left(queen_position, board):
    return queen_action_top_left(queen_position, board, -1)


def queen_leave_bottom_right(queen_position, board):
    return queen_action_bottom_right(queen_position, board, -1)


def queen_leave_bottom_left(queen_position, board):
    return queen_action_bottom_left(queen_position, board, -1)


def queen_leave_horizontal(queen_position, board):
    return queen_action_horizontal(queen_position, board, -1)


def queen_leave_vertical(queen_position, board):
    return queen_action_vertical(queen_position, board, -1)


# Apply the board changes when the attack/leave helper functions are used
def queen_action_top_right(queen_position, board, action):
    col_offset = 1
    for i in range(queen_position[0]-1, -1, -1):
        if queen_position[1]+col_offset < n:
            board[i][queen_position[1]+col_offset] += action
            col_offset += 1
    return board


def queen_action_top_left(queen_position, board, action):
    col_offset = 1
    for i in range(queen_position[0]-1, -1, -1):
        if queen_position[1]-col_offset >= 0:
            board[i][queen_position[1]-col_offset] += action
            col_offset += 1
    return board


def queen_action_bottom_right(queen_position, board, action):
    col_offset = 1
    for i in range(queen_position[0]+1, n):
        if queen_position[1]+col_offset < n:
            board[i][queen_position[1]+col_offset] += action
            col_offset += 1
    return board


def queen_action_bottom_left(queen_position, board, action):
    col_offset = 1
    for i in range(queen_position[0]+1, n):
        if queen_position[1]-col_offset >= 0:
            board[i][queen_position[1]-col_offset] += action
            col_offset += 1
    return board


def queen_action_horizontal(queen_position, board, action):
    for i in range(0, queen_position[1]):
        board[queen_position[0]][i] += action

    for i in range(queen_position[1]+1, n):
        board[queen_position[0]][i] += action

    return board


def queen_action_vertical(queen_position, board, action):
    for i in range(0, queen_position[0]):
        board[i][queen_position[1]] += action

    for i in range(queen_position[0]+1, n):
        board[i][queen_position[1]] += action

    return board

queens_positions, board = init_queens_board(queens_positions, board)
find_solution(queens_positions, board, history)
