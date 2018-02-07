#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math
import os
import numpy as np
import csv
import random
import time

test_data = []
trainess_data = []

APP_ROOT = os.path.dirname(os.path.abspath(__file__))

def read_input_csv(filename, prepend=False):
    data = []

    with open(os.path.join(APP_ROOT, filename), 'r') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        for row in reader:
            if row != []:
                new = [float(x) for x in row if x != '']

                if prepend:
                    new = ['-1.0'] + new

                data.append(new)
    return data


def split_input_data(input_data):
    test_data = []
    trainess_data = []

    test_data = random.sample(input_data, 20)
    trainess_data = [i for i in input_data if i not in test_data]

    return test_data, trainess_data


def print_data_set(data_set):
    for i in range(len(data_set)):
        print(data_set[i])


def find_distance_between_dots(dot1, dot2):
    distance = 0

    for i in range(1, len(dot1)):
        diff = dot2[i] - dot1[i]
        distance += diff * diff
    return math.sqrt(distance)


def caluclate_distances(trainees_data, point):
    distances = []

    # First calculate the distance between the new point and the base points
    for i in range(len(trainees_data)):
        distance = find_distance_between_dots(trainees_data[i], point)
        distances.append(distance)

    # Next, normalize the calucalted distances
    normalized_distances = []
    max_distance = max(distances)
    for i in range(len(distances)):
        normalized_distance = distances[i] / max_distance
        normalized_distances.append(1 / normalized_distance)

    return normalized_distances


def find_k_nearest_neighbours(trainees_data, distances, point):
    k = 103  # To DO

    distances_range = range(len(distances))
    sorted_distances = sorted(distances_range, key=lambda k: distances[k], reverse=True)

    found_point_types = {}
    for i in range(len(sorted_distances)):
        point_type = trainees_data[sorted_distances[i]][0]

        if point_type not in found_point_types:
            found_point_types[point_type] = 0

        found_point_types[point_type] += 1

        if found_point_types[point_type] == k:
            return point_type


def find_input_data_types(trainees_data, test_data):
    results = {
        'algorithm': 'KNN',
        'train_data_length': len(trainees_data),
        'test_data_length': len(test_data),
        'accuracy': 0,
        'successfully_classified': 0,
        'classification': None
    }

    check_classification = True
    if (len(test_data) == 1):
        check_classification = False

    output_results = []

    for i in range(len(test_data)):
        distances = caluclate_distances(trainees_data, test_data[i])
        result = find_k_nearest_neighbours(trainees_data, distances, test_data[i])

        if check_classification:
            output_results.append(result)
            expected = test_data[i][0]

            if result == expected:
                results['successfully_classified'] += 1
                #print('   (E): ' + str(expected) + '; (R): ' + str(result))
            #else:
                #print('Х: (E): ' + str(expected) + '; (R): ' + str(result))
        else:
            results['classification'] = result
            print('   Classificated as ' + result)

    # with open(os.path.join(APP_ROOT, 'output/knn.csv'), 'wb') as csvfile:
    #     output = csv.writer(csvfile, delimiter=',')
    #     output.writerow(['ImageId', 'Label'])

    #     for i in range(len(test_data)):
    #         output.writerow([i, int(output_results[i])])

    results['accuracy'] = (float(results['successfully_classified']) / float(results['test_data_length'])) * 100
    return results


def clasiffy(input_test_data=None):
    if input_test_data is None:
        print('Start reading data')
        trainees_data = read_input_csv('datasets/train.lite.csv')
        test_data = read_input_csv('datasets/test.lite.csv', True)
        #print('Split data into two datasets')
        #test_data, trainees_data = split_input_data(base_data)
    else:
        print('Start reading data')
        trainees_data = read_input_csv('datasets/train.lite.csv')
        test_data = [input_test_data['data']]

    print('Start classification')

    start_time = time.time()
    results = find_input_data_types(trainees_data, test_data)
    end_time = time.time()

    print('Classification finished')
    print(end_time - start_time)

    results['execution_time'] = int(end_time - start_time)

    return results


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


def crossfold():
    print('Start reading data')
    base_data = read_input_csv('datasets/train.csv', False)
    filtered_data = random.sample(base_data, 10000)
    data_chunks = separate_to_chunks(filtered_data, 10)

    print('Start classification')

    start_time = time.time()

    print('All' + str(len(filtered_data)))

    overall_accuracy = 0
    for i in range(len(data_chunks)):
        trainess_data = data_chunks[i]
        test_data = data_chunks[:i] + data_chunks[i+1:len(data_chunks)]

        test_data = []
        for j in range(len(data_chunks)):
            if i != j:
                test_data += data_chunks[j]

        #print('Train ' + str(len(trainess_data)))
        #print('Test ' + str(len(test_data)))

        #results = find_input_data_types(trainess_data, test_data)
        results = find_input_data_types(test_data, trainess_data)
        accuracy = results['accuracy']
        print(results)

        overall_accuracy += accuracy
        print('Chunk ' + str(i) + '; Accuracy: ' + str(accuracy) + '%')

    overall_accuracy = overall_accuracy / len(data_chunks)
    print('Overall accuracy: ' + str(overall_accuracy) + '%')

    end_time = time.time()

    print('Classification finished')
    print(end_time - start_time)

    results['execution_time'] = int(end_time - start_time)

    return results


if __name__ == "__main__":
    print('KNN')
    results = crossfold()
