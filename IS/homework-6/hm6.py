
import math
import numpy as np
import csv
import random

base_data = []
test_data = []
trainess_data = []


def read_input_csv():
    data = []
    with open('iris.data.csv', 'r') as csvfile:
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
    for i in range(len(dot1)-1):
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
    k = 3  # To DO
    distances_range = range(len(distances))
    sorted_distances = sorted(distances_range, key=lambda k: distances[k], reverse=True)

    found_point_types = {}
    for i in range(len(sorted_distances)):
        point_type = trainees_data[sorted_distances[i]][len(point)-1]

        if point_type not in found_point_types:
            found_point_types[point_type] = 0
        found_point_types[point_type] += 1

        if found_point_types[point_type] == k:
            return point_type


def find_input_data_types(trainees_data, test_data):
    success_rate = 0
    for i in range(len(test_data)):
        distances = caluclate_distances(trainees_data, test_data[i])
        result = find_k_nearest_neighbours(trainees_data, distances, test_data[i])
        expected = test_data[i][len(test_data[i])-1]
        if result == expected:
            success_rate += 1
            print('   (E): ' + expected + '; (R): ' + result)
        else:
            print('Х: (E): ' + expected + '; (R): ' + result)

    print()
    print('Success rate: ' + str((success_rate/len(test_data))*100) + '%')


base_data = read_input_csv()
test_data, trainees_data = split_input_data(base_data)

find_input_data_types(trainees_data, test_data)
