
import math
import numpy as np
import csv
import random
from collections import Counter

test_data = []
trainess_data = []

classes_probabilities = None
attributes_probabilities = None

APP_ROOT = os.path.dirname(os.path.abspath(__file__))


def read_input_csv(filename):
    data = []
    with open(os.path.join(APP_ROOT, filename), 'r') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        for row in reader:
            if row != []:
                data.append(row)
    return data


def print_data_set(data_set):
    for i in range(len(data_set)):
        print(data_set[i])


def separate_to_chunks(data_set, n):
    data = list(data_set)
    random.shuffle(data)
    data_length = len(data)
    chunk_size = int(data_length / n)

    chunks = [data[0+chunk_size*i: chunk_size*(i+1)] for i in range(n)]
    leftover = data_length - chunk_size*n
    edge = chunk_size*n
    for i in range(leftover):
            chunks[i % n].append(data[edge+i])
    return chunks


def init_classes_probabilities(data):
    occuranciesCounter = {
        '0': 0,
        '1': 0,
        '2': 0,
        '3': 0,
        '4': 0,
        '5': 0,
        '6': 0,
        '7': 0,
        '8': 0,
        '9': 0,
    }

    for i in range(len(data)):
        occuranciesCounter[data[i][0]] += 1

    return {
        '0': occuranciesCounter['0'] / len(data),
        '1': occuranciesCounter['1'] / len(data),
        '2': occuranciesCounter['2'] / len(data),
        '3': occuranciesCounter['3'] / len(data),
        '4': occuranciesCounter['4'] / len(data),
        '5': occuranciesCounter['5'] / len(data),
        '6': occuranciesCounter['6'] / len(data),
        '7': occuranciesCounter['7'] / len(data),
        '8': occuranciesCounter['8'] / len(data),
        '9': occuranciesCounter['9'] / len(data),
    }


def init_attribute_probabilities(data, attribute, item_class):
    occuranciesCounter = {
        '\'y\'': 0,
        '\'n\'': 0,
        '?': 0,
    }

    for i in range(len(data)):
        if data[i][len(data[i])-1] == item_class:
            occuranciesCounter[data[i][attribute]] += 1

    return {
        '\'y\'': occuranciesCounter['\'y\''] / len(data),
        '\'n\'': occuranciesCounter['\'n\''] / len(data),
    }


def init_attributes_probabilities(data):
    attributes_probabilities = []

    for i in range(len(data[0]) - 1):
        attr_democart_prob = init_attribute_probabilities(data, i, '\'democrat\'')
        attr_republican_prob = init_attribute_probabilities(data, i, '\'republican\'')
        attributes_probabilities.append({
            '\'democrat\'': attr_democart_prob,
            '\'republican\'': attr_republican_prob,
        })

    return attributes_probabilities


def naive_bayees(data, classes_probabilities, attributes_probabilities):
    accuracy = 0
    for i in range(len(data)):
        democrat_sum = classes_probabilities['\'democrat\'']
        republican_sum = classes_probabilities['\'republican\'']

        for j in range(len(data[i])-1):
            if data[i][j] != '?':
                democrat_sum *= attributes_probabilities[j]['\'democrat\''][data[i][j]]
                republican_sum *= attributes_probabilities[j]['\'republican\''][data[i][j]]

        #print(democrat_sum)
        #print(republican_sum)

        result = '\'democrat\'' if democrat_sum > republican_sum else '\'republican\''
        expected = data[i][len(data[i])-1]

        if result == expected:
            accuracy += 1
            #print('   (E): ' + expected + '; (R): ' + result)
        #else:
            #print('Х: (E): ' + expected + '; (R): ' + result)

    return (accuracy/len(data))*100