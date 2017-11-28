
import math
import numpy as np

base_data = [
    [1, 10, 0],
    [2, 10, 0],
    [3, 11, 0],
    [2, 9, 0],
    [3, 9, 0],

    [1, 2, 1],
    [2, 2, 1],
    [3, 3, 1],
    [3, 2, 1],

    [5, 5, 2],
    [5, 6, 2],
    [5, 7, 2],
    [6, 6, 2],
    [7, 7, 2],
]

input_data = [
    [2, 11],
    [2.5, 2],
    [5.5, 6],
]


def find_distance_between_dots(dot1, dot2):
    distance = 0
    for i in range(len(dot2)):
        distance += (dot2[i] - dot1[i]) * (dot2[i] - dot1[i])
    return math.sqrt(distance)


def caluclate_distances(base_data, point):
    distances = []

    # First calculate the distance between the new point and the base points
    for i in range(len(base_data)):
        distance = find_distance_between_dots(base_data[i], point)
        distances.append(distance)

    # Next, normalize the calucalted distances
    normalized_distances = []
    max_distance = max(distances)
    for i in range(len(distances)):
        normalized_distance = distances[i] / max_distance
        normalized_distances.append(1 / normalized_distance)

    return normalized_distances


def find_k_nearest_neighbours(base_data, distances, point):
    k = 3  # To DO
    distances_range = range(len(distances))
    sorted_distances = sorted(distances_range, key=lambda k: distances[k], reverse=True)

    found_point_types = {}
    for i in range(len(sorted_distances)):
        point_type = base_data[sorted_distances[i]][2]

        if point_type not in found_point_types:
            found_point_types[point_type] = 0
        found_point_types[point_type] += 1

        if found_point_types[point_type] == k:
            return point_type


def find_input_data_types(base_data, input_data):
    for i in range(len(input_data)):
        distances = caluclate_distances(base_data, input_data[i])
        #print(distances)
        print(find_k_nearest_neighbours(base_data, distances, input_data[i]))

find_input_data_types(base_data, input_data)
