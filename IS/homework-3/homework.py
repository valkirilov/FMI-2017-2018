
n = 4

# Queens orderred by rows with their positions by columns
queens_positions = [2, 0, 3, 1]


def print_queens_board(queens):
    for row in range(0, n):
        if queens[row] == -1:
            print('_'*n)
        else:
            print(('_'*queens[row]) + '*' + ('_'*(n-queens[row]-1)))


def print_chess_board(board):
    for row in range(0, n):
        print(board[row])


def calculate_board_weight(queens):
    print('Todo')
    board = [x[:] for x in [[0] * n] * n]

    print_chess_board(board)
    for i in range(0, n):
        board = queen_attack_top_right(i, queens[i], board)
        board = queen_attack_top_left(i, queens[i], board)
        board = queen_attack_bottom_right(i, queens[i], board)
        board = queen_attack_bottom_left(i, queens[i], board)
        print()
        print_chess_board(board)


def queen_attack_top_right(row, queen_position, board):
    col_offset = 1
    for i in range(row-1, -1, -1):
        if queen_position+col_offset < n:
            board[i][queen_position+col_offset] += 1
            col_offset += 1
    return board


def queen_attack_top_left(row, queen_position, board):
    col_offset = 1
    for i in range(row-1, -1, -1):
        if queen_position-col_offset >= 0:
            board[i][queen_position-col_offset] += 1
            col_offset += 1
    return board


def queen_attack_bottom_right(row, queen_position, board):
    col_offset = 1
    for i in range(row+1, n):
        if queen_position+col_offset < n:
            board[i][queen_position+col_offset] += 1
            col_offset += 1
    return board


def queen_attack_bottom_left(row, queen_position, board):
    col_offset = 1
    for i in range(row+1, n):
        if queen_position-col_offset >= 0:
            board[i][queen_position-col_offset] += 1
            col_offset += 1
    return board


print_queens_board(queens_positions)
calculate_board_weight(queens_positions)
