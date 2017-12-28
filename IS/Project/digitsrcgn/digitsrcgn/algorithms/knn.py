#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math
import os
import numpy as np
import csv
import random

test_data = []
trainess_data = []


def read_input_csv():
    data = []

    APP_ROOT = os.path.dirname(os.path.abspath(__file__))   # refers to application_top

    with open(os.path.join(APP_ROOT, 'datasets/train.csv'), 'r') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        for row in reader:
            if row != []:
                data.append(row)
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
        distance += (float(dot2[i]) - float(dot1[i])) * (float(dot2[i]) - float(dot1[i]))
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
    k = 5  # To DO
    distances_range = range(len(distances))
    sorted_distances = sorted(distances_range, key=lambda k: distances[k], reverse=True)

    found_point_types = {}
    for i in range(len(sorted_distances)):
        point_type = trainees_data[sorted_distances[i]][0]

        #print(found_point_types)

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

    for i in range(len(test_data)):
        distances = caluclate_distances(trainees_data, test_data[i])
        result = find_k_nearest_neighbours(trainees_data, distances, test_data[i])

        if check_classification:
            expected = test_data[i][0]
            if result == expected:
                results['successfully_classified'] += 1
                print('   (E): ' + expected + '; (R): ' + result)
            else:
                print('Х: (E): ' + expected + '; (R): ' + result)
        else:
            results['classification'] = result
            print('   Classificated as ' + result)


    results['accuracy'] = (float(results['successfully_classified']) / float(results['test_data_length'])) * 100
    return results


def clasiffy(input_test_data=None):
    if input_test_data is None:
        print('Start reading data')
        base_data = read_input_csv()
        print('Split data into two datasets')
        test_data, trainees_data = split_input_data(base_data)
    else:
        print('Start reading data')
        trainees_data = read_input_csv()
        test_data = [input_test_data['data']]

    print('Start classification')
    results = find_input_data_types(trainees_data, test_data)
    return results
