import os
import math
import numpy as np
import csv
import random
from collections import Counter
from operator import attrgetter

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


def print_attributes_probabilitirs(attributes_probabilities):
    for i in range(len(attributes_probabilities)):
        print(attributes_probabilities[i])


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


def mean(data):
    return sum(data)/float(len(data))


def stdev(data):
    print(data)
    avg = mean(data)
    variance = sum([pow(x-avg,2) for x in data])/float(len(data)-1)
    return math.sqrt(variance)


def calculateProbability(x, mean, stdev):
    exponent = math.exp(-(math.pow(x-mean,2)/(2*math.pow(stdev,2))))
    return (1 / (math.sqrt(2*math.pi) * stdev)) * exponent


def init_attribute_probabilities(data, attribute, item_class):
    #print(attribute)
    #print(item_class)
    #print(len(data))

    attribute_data = []

    for i in range(len(data)):
        if data[i][0] == item_class:
            attribute_data.append(float(data[i][attribute]))

    #print(attribute_data)

    if len(attribute_data) > 0:
        x = float(data[i][attribute])
        m = mean(attribute_data)
        sd = stdev(attribute_data)

        if sd == 0:
            probability = 1
        else:
            probability = calculateProbability(x, m, sd)

        #print(m)
        #print(sd)
        #print(probability)
    else:
        probability = 1

    return probability


def init_attributes_probabilities(data):
    attributes_probabilities = []

    for i in range(len(data[0]) - 1):
        attr_0_prob = init_attribute_probabilities(data, i, '0')
        attr_1_prob = init_attribute_probabilities(data, i, '1')
        attr_2_prob = init_attribute_probabilities(data, i, '2')
        attr_3_prob = init_attribute_probabilities(data, i, '3')
        attr_4_prob = init_attribute_probabilities(data, i, '4')
        attr_5_prob = init_attribute_probabilities(data, i, '5')
        attr_6_prob = init_attribute_probabilities(data, i, '6')
        attr_7_prob = init_attribute_probabilities(data, i, '7')
        attr_8_prob = init_attribute_probabilities(data, i, '8')
        attr_9_prob = init_attribute_probabilities(data, i, '9')

        attributes_probabilities.append({
            '0': attr_0_prob,
            '1': attr_1_prob,
            '2': attr_2_prob,
            '3': attr_3_prob,
            '4': attr_4_prob,
            '5': attr_5_prob,
            '6': attr_6_prob,
            '7': attr_7_prob,
            '8': attr_8_prob,
            '9': attr_9_prob,
        })

    return attributes_probabilities


def get_max_probability(data):
    current_max = data[0]
    for i in range(len(data)):
        if (data[i]['probability'] > current_max['probability']):
            current_max = data[i]
    return current_max


def naive_bayees(data, classes_probabilities, attributes_probabilities):
    accuracy = 0
    for i in range(len(data)):
        class_0_prop = {'class': '0', 'probability': classes_probabilities['0']}
        class_1_prop = {'class': '1', 'probability': classes_probabilities['1']}
        class_2_prop = {'class': '2', 'probability': classes_probabilities['2']}
        class_3_prop = {'class': '3', 'probability': classes_probabilities['3']}
        class_4_prop = {'class': '4', 'probability': classes_probabilities['4']}
        class_5_prop = {'class': '5', 'probability': classes_probabilities['5']}
        class_6_prop = {'class': '6', 'probability': classes_probabilities['6']}
        class_7_prop = {'class': '7', 'probability': classes_probabilities['7']}
        class_8_prop = {'class': '8', 'probability': classes_probabilities['8']}
        class_9_prop = {'class': '9', 'probability': classes_probabilities['9']}

        for j in range(len(data[i])-1):
            class_0_prop['probability'] *= attributes_probabilities[j]['0']
            class_1_prop['probability'] *= attributes_probabilities[j]['1']
            class_2_prop['probability'] *= attributes_probabilities[j]['2']
            class_3_prop['probability'] *= attributes_probabilities[j]['3']
            class_4_prop['probability'] *= attributes_probabilities[j]['4']
            class_5_prop['probability'] *= attributes_probabilities[j]['5']
            class_6_prop['probability'] *= attributes_probabilities[j]['6']
            class_7_prop['probability'] *= attributes_probabilities[j]['7']
            class_8_prop['probability'] *= attributes_probabilities[j]['8']
            class_9_prop['probability'] *= attributes_probabilities[j]['9']

        print(class_0_prop)
        print(class_1_prop)
        print(class_2_prop)
        print(class_3_prop)
        print(class_4_prop)
        print(class_5_prop)
        print(class_6_prop)
        print(class_7_prop)
        print(class_8_prop)
        print(class_9_prop)
        exit(0)

        expected = data[i][0]
        clasees_prop_list = [class_0_prop, class_1_prop, class_2_prop, class_3_prop, class_4_prop, class_5_prop, class_6_prop, class_7_prop, class_8_prop, class_9_prop]
        result = get_max_probability(clasees_prop_list)

        print(result)

        if result['class'] == expected:
            accuracy += 1
            print('   (E): ' + expected + '; (R): ' + result['class'])
        else:
            print('Х: (E): ' + expected + '; (R): ' + result['class'])

    return (accuracy/len(data))*100


def run_naive_bayees_with_chunks(data_chunks):
    overall_accuracy = 0
    for i in range(len(data_chunks)):
        trainess_data = data_chunks[i]
        test_data = data_chunks[:i] + data_chunks[i+1:len(data_chunks)]

        classes_probabilities = init_classes_probabilities(trainess_data)
        print(classes_probabilities)

        attributes_probabilities = init_attributes_probabilities(trainess_data)
        print_attributes_probabilitirs(attributes_probabilities)

        accuracy = 0
        for j in range(len(test_data)):
            accuracy += naive_bayees(test_data[j], classes_probabilities, attributes_probabilities)

        accuracy = accuracy / len(test_data)
        overall_accuracy += accuracy
        print('Chunk ' + str(i) + '; Accuracy: ' + str(accuracy) + '%')

    overall_accuracy = overall_accuracy / len(data_chunks)
    print('Overall accuracy: ' + str(overall_accuracy) + '%')


if __name__ == "__main__":
    print('Naive Bayees')

    base_data = read_input_csv('datasets/train.test.csv')
    data_chunks = separate_to_chunks(base_data, 10)

    run_naive_bayees_with_chunks(data_chunks)

