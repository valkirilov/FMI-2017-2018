
import random

n = 4

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
        print('Position ' + str(i) + 'th queen')
        position, value = get_board_row_cheapest_position(board, i)
        queens_positions[i] = position
        print(' Cheapest posotion is at: ' + str(position))
        print_queens_board(queens_positions)
        board = calculate_board_weight(queens_positions, board, i)

    return queens_positions, board


def calculate_board_weight(queens, board, attack_position, leave_position=None):
    print_chess_board(board)
    i = attack_position
    j = leave_position

    print('Calculate chess board')
    print_chess_board(board)
    if j is not None:
        print('Leave queen from position ' + str(j))
        board = queen_leave_top_right(j[0], j[1], board)
        board = queen_leave_top_left(j[0], j[1], board)
        board = queen_leave_bottom_right(j[0], j[1], board)
        board = queen_leave_bottom_left(j[0], j[1], board)
        board = queen_leave_vertical(j[0], j[1], board)
        print()
        print_chess_board(board)

    if queens[i] is not -1:
        print('Move queen and attck to position ' + str(i) + ', ' + str(queens[i]))
        board = queen_attack_top_right(i, queens[i], board)
        board = queen_attack_top_left(i, queens[i], board)
        board = queen_attack_bottom_right(i, queens[i], board)
        board = queen_attack_bottom_left(i, queens[i], board)
        board = queen_attack_vertical(i, queens[i], board)
        print()
        print_chess_board(board)

    return board


def get_board_cheapest_position(board):
    cheapest_positions_by_rows = []
    for i in range(0, n):
        index, value = get_board_row_cheapest_position(board, i)
        cheapest_positions_by_rows.append((value, index, i)) # (value, col, row)

    print_chess_board(board)
    print('Cheapest positions by rows: (value, col, row)')
    print(cheapest_positions_by_rows)

    cheapest_position = min(cheapest_positions_by_rows)
    print('The cheapest position is: ' + str(cheapest_position))
    return cheapest_position


def get_board_row_cheapest_position(board, row):
    row_without_queen = []

    #print('The queen is at position: ' + str(queens_positions[row]))
    for i in range(0, n):
        if (i is not queens_positions[row]):
            row_without_queen.append((board[row][i], i))

    cheapest_position = min(row_without_queen)
    #print(row_without_queen)
    #print('Minimum value of ' + str(cheapest_position[1]) + ' found on position ' + str(cheapest_position[0]))
    return cheapest_position[1], cheapest_position[0]


def make_move(queens_positions, board, new_position):
    old_position = (new_position[2], queens_positions[new_position[2]])
    queens_positions[new_position[2]] = new_position[1]

    print_queens_board(queens_positions)

    board = calculate_board_weight(queens_positions, board, new_position[2], old_position)
    return queens_positions, board


def check_is_final(queens_positions, board):
    for i in range(0, n):
        if board[i][queens_positions[i]] is not 0:
            return False
    return True


def find_solution(queens_positions, board):
    if check_is_final(queens_positions, board):
        print('Solution found')
        print_queens_board(queens_positions)
        print_chess_board(board)
        exit()

    for i in range(0, 100):
        print('Searching for solution. Attempt #' + str(i))
        input("Press Enter to continue...")
        print_queens_board(queens_positions)
        cheapest_position = get_board_cheapest_position(board)
        queens_positions, board = make_move(queens_positions, board, cheapest_position)



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


queens_positions, board = init_queens_board(queens_positions, board)
find_solution(queens_positions, board)

