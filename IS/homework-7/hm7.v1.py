
import math
import numpy as np
import csv
import random
from collections import Counter

base_data = []
test_data = []
trainess_data = []

classes_probabilities = None
attributes_probabilities = None


def read_input_csv():
    data = []
    with open('vote.csv', 'r') as csvfile:
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
        '\'democrat\'': 0,
        '\'republican\'': 0,
    }

    for i in range(len(data)):
        occuranciesCounter[data[i][len(data[i])-1]] += 1

    return {
        '\'democrat\'': occuranciesCounter['\'democrat\''] / len(data),
        '\'republican\'': occuranciesCounter['\'republican\''] / len(data),
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


def run_naive_bayees_with_chunks(data_chunks):
    overall_accuracy = 0
    for i in range(len(data_chunks)):
        trainess_data = data_chunks[i]
        test_data = data_chunks[:i] + data_chunks[i+1:len(data_chunks)]

        classes_probabilities = init_classes_probabilities(trainess_data)
        #print(classes_probabilities)

        attributes_probabilities = init_attributes_probabilities(trainess_data)
        #print(attributes_probabilities)

        accuracy = 0
        for j in range(len(test_data)):
            accuracy += naive_bayees(test_data[j], classes_probabilities, attributes_probabilities)

        accuracy = accuracy / len(test_data)
        overall_accuracy += accuracy
        print('Chunk ' + str(i) + '; Accuracy: ' + str(accuracy) + '%')

    overall_accuracy = overall_accuracy / len(data_chunks)
    print('Overall accuracy: ' + str(overall_accuracy) + '%')


base_data = read_input_csv()
data_chunks = separate_to_chunks(base_data, 10)
run_naive_bayees_with_chunks(data_chunks)
