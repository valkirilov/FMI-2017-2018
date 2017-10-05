
from node import Node

# Build the nodes
n1 = Node(1)
n2 = Node(2)
n3 = Node(3)
n4 = Node(4)
n5 = Node(5)
n6 = Node(6)
n7 = Node(7)
n8 = Node(8)
n9 = Node(9)
n10 = Node(10)
n11 = Node(11)
n12 = Node(12)

# Make the connections between the nodes
n1.add_child(n2)
n1.add_child(n3)
n1.add_child(n4)

n2.add_child(n5)
n2.add_child(n6)

n4.add_child(n7)
n4.add_child(n8)

n5.add_child(n9)
n5.add_child(n10)

n7.add_child(n11)
n7.add_child(n12)

# Basic dump of the top level of the tree
#for c in n1.children:
#    print c.data

print('DFS')

# DFS Algoruthm
stack = [n1]
visited = []

while True:
    if len(stack) == 0:
        print('Done.')
        break;

    current = stack.pop()
    print(current.data)

    for child in current.children:
        if  child not in visited:
            visited.append(child)
            stack.append(child)


