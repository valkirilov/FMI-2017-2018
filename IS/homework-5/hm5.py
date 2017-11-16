
import copy

input_board = [
                [-1, 0, -1],
                [0, 1, 1],
                [1, 0, -1]
            ]

input_player = 1


def print_board(board):
    for i in range(3):
        line = str(board[i])
        line = line.replace('-1', 'O ')
        line = line.replace('1', 'X ')
        line = line.replace('0', '  ')

        line = line.replace(', ', '')
        line = line.replace('[', '')
        line = line.replace(']', '')
        print(line)
    print('-----')


def is_final(board):
    # Chech for horizontal winner
    if (board[0][0] == board[0][1] == board[0][2]) and board[0][0] != 0:
        return True
    if (board[1][0] == board[1][1] == board[1][2]) and board[1][0] != 0:
        return True
    if (board[2][0] == board[2][1] == board[2][2]) and board[2][0] != 0:
        return True

    # Chech for vertical winner
    if (board[0][0] == board[1][0] == board[2][0]) and board[0][0] != 0:
        return True
    if (board[0][1] == board[1][1] == board[2][1]) and board[0][1] != 0:
        return True
    if (board[0][2] == board[1][2] == board[2][2]) and board[0][2] != 0:
        return True

    # Check the diagonals
    if (board[0][0] == board[1][1] == board[2][2]) and board[0][0] != 0:
        return True
    if (board[2][0] == board[1][1] == board[0][2]) and board[2][0] != 0:
        return True

    return False


def heuristic(board, is_max):
    empty_spaces = 0

    for i in range(3):
        empty_spaces += board[i].count(0)

    if is_final(board):
        if is_max:
            return 1 + empty_spaces
        else:
            return -1 - empty_spaces
    else:
        return 0


def generate_children(node, is_max):
    empty_spaces = []

    for i in range(3):
        for j in range(3):
            if node[i][j] == 0:
                empty_spaces.append((i, j))

    children = []
    for space in empty_spaces:
        new_node = copy.deepcopy(node)
        new_node[space[0]][space[1]] = 1 if is_max else -1
        children.append(new_node)

    return children


def alphabeta(node, a, b, is_max):
    #print('Alphabeta called: a: ' + str(a) + ' b: ' + str(b) + ' player: ' + str(is_max))
    print_board(node)
    if is_final(node):
        print('Final with heuristic: ' + str(heuristic(node, is_max)))
        print_board(node)
        return heuristic(node, is_max)

    if is_max:
        v = -1000000
        children = generate_children(node, is_max)
        #print(children)
        for child in children:
            v = max(v, alphabeta(child, a, b, False))
            a = max(a, v)
            print('v=' + str(v))
            print('a=' + str(a))
            print('b=' + str(a))
            if b <= a:
                print('Break 1')
                break
        return v
    else:
        v = 1000000
        children = generate_children(node, is_max)
        #print(children)
        for child in children:
            v = min(v, alphabeta(child, a, b, True))
            b = min(b, v)
            print('v=' + str(v))
            print('a=' + str(a))
            print('b=' + str(a))
            if b <= a:
                print('Break 2')
                break
        return v

print_board(input_board)
result = alphabeta(input_board, 1, -1, True)
print('Result: ' + str(result))
