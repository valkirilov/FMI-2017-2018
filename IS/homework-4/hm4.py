
import numpy as np
import random

# Capacity of the bag
bag_capacity = None

# Number of the items
items_count = None

# Number of states in our population
population_states_count = 300

# How mane ages of mutation we will watch
ages_count = 50

# Selection process percent
selection_percent = 0.2

# Mutation process percent
mutation_percent = 0.05

# Items list, holding tuples of (value, weight)
items = []

# Our population states are kept here
population_states = []


def read_input():
    line = input()
    bag_capacity, items_count = line.split(' ')

    bag_capacity = int(bag_capacity)
    items_count = int(items_count)

    for i in range(items_count):
        line = input()
        value, weight = line.split(' ')
        items.append((int(value), int(weight)))

    return bag_capacity, items_count, items


def init_random_population(population_states_count):
    population_states = []

    for i in range(population_states_count):
        while True:
            state = np.random.binomial(1, 0.1, size=items_count)
            if fitness(state) > 0:
                population_states.append(state)
                break

    # Sort states by fitness function
    population_states = sorted(population_states, key=fitness, reverse=True)

    return population_states


def fitness(state):
    values_sum = 0
    weight_sum = 0

    for i in range(items_count):
        if state[i] == 1:
            values_sum += items[i][0]
            weight_sum += items[i][1]

    if weight_sum > bag_capacity:
        return 0

    return values_sum


def compare_states(state1, state2):
    if fitness(state1) < fitness(state2):
        return -1
    elif fitness(state1) > fitness(state2):
        return 1
    else:
        return 0


def genetic_algorithm(population_states):
    for age in range(ages_count):
        print('Start age ' + str(age))
        for k in range(population_states_count):
            child = None
            while True:
                child = generate_crossover(population_states)
                if fitness(child) > 0:
                    break

            while True:
                child = mutate_state(child)
                if fitness(child) > 0:
                    break

            population_states.append(child)
            population_states = sorted(population_states, key=fitness, reverse=True)
            population_states = population_states[0:population_states_count]

        # Log best state
        print(fitness(population_states[0]))


def generate_crossover(population_states):
    # Filter the best percents for selection
    selection_count = int(selection_percent * population_states_count)
    #print('Filter for selection first ' + str(selection_count) + ' states')

    selection = population_states[:selection_count]
    #print(selection)
    parents_indexes = random.sample(range(0, selection_count-1), 2)
    parent1 = selection[parents_indexes[0]]
    parent2 = selection[parents_indexes[1]]

    #print('Parents')
    #print(parent1)
    #print(parent2)
    child = make_crossover(parent1, parent2)
    #print('Child')
    #print(child)

    return child


def make_crossover(parent1, parent2):
    crossover_point = random.randint(0, items_count-2)
    #print('Crossover point is ' + str(crossover_point))
    part1 = parent1[:crossover_point+1]
    part2 = parent2[crossover_point+1:items_count]
    child = list(part1) + list(part2)
    return child


def mutate_state(state):
    chance = random.randint(1, 100)
    mutation_chance = mutation_percent * 100

    if chance <= mutation_chance:
        #print('Mutate state')
        mutation_index = random.randint(0, items_count-1)
        state[mutation_index] = 0 if state[mutation_index] == 1 else 1

    return state


bag_capacity, items_count, items = read_input()
population_states = init_random_population(population_states_count)
genetic_algorithm(population_states)

