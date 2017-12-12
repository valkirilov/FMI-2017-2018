
import math
import numpy as np
import csv
import random

base_data = []
test_data = []
trainess_data = []

# 9. Class Distribution: (2 classes)
#    1. 45.2 percent are democrat
#    2. 54.8 percent are republican
classes_probabilities = {
    'democrat': 0.452,
    'republican': 0.548,
}

attributes_probabilities = None


def read_input_csv():
    data = []
    with open('lite.vote.csv', 'r') as csvfile:
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


def init_attribute1_probabilities():
    #  Attribute 1: (A = handicapped-infants)
    #   0.91;  1.21  (C=democrat; V=y)
    #   0.09;  0.10  (C=republican; V=y)
    #   0.43;  0.38  (C=democrat; V=n)
    #   0.57;  0.41  (C=republican; V=n)
    #   0.75;  0.03  (C=democrat; V=?)
    #   0.25;  0.01  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0.91, 1.21])
    probabilities_list.append([0.09, 0.10])
    probabilities_list.append([0.43, 0.38])
    probabilities_list.append([0.57, 0.41])
    probabilities_list.append([0.75, 0.03])
    probabilities_list.append([0.25, 0.01])

    return probabilities_list


def init_attribute2_probabilities():
    #  Attribute 2: (A = water-project-cost-sharing)
    #   0.62;  0.45  (C=democrat; V=y)
    #   0.38;  0.23  (C=republican; V=y)
    #   0.62;  0.45  (C=democrat; V=n)
    #   0.38;  0.23  (C=republican; V=n)
    #   0.58;  0.10  (C=democrat; V=?)
    #   0.42;  0.06  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0.62, 0.45])
    probabilities_list.append([0.38, 0.23])
    probabilities_list.append([0.62, 0.45])
    probabilities_list.append([0.38, 0.23])
    probabilities_list.append([0.58, 0.10])
    probabilities_list.append([0.42, 0.06])

    return probabilities_list


def init_attribute3_probabilities():
    #  Attribute 3: (A = adoption-of-the-budget-resolution)
    #   0.91;  0.87  (C=democrat; V=y)
    #   0.09;  0.07  (C=republican; V=y)
    #   0.17;  0.11  (C=democrat; V=n)
    #   0.83;  0.44  (C=republican; V=n)
    #   0.64;  0.03  (C=democrat; V=?)
    #   0.36;  0.01  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0.91, 0.87])
    probabilities_list.append([0.09, 0.07])
    probabilities_list.append([0.17, 0.11])
    probabilities_list.append([0.83, 0.44])
    probabilities_list.append([0.64, 0.03])
    probabilities_list.append([0.36, 0.01])

    return probabilities_list


def init_attribute4_probabilities():
    #  Attribute 4: (A = physician-fee-freeze)
    #   0.08;  0.05  (C=democrat; V=y)
    #   0.92;  0.50  (C=republican; V=y)
    #   0.99;  0.92  (C=democrat; V=n)
    #   0.01;  0.01  (C=republican; V=n)
    #   0.73;  0.03  (C=democrat; V=?)
    #   0.27;  0.01  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0.08, 0.05])
    probabilities_list.append([0.92, 0.50])
    probabilities_list.append([0.99, 0.92])
    probabilities_list.append([0.01, 0.01])
    probabilities_list.append([0.73, 0.03])
    probabilities_list.append([0.27, 0.01])

    return probabilities_list


def init_attribute5_probabilities():
#  Attribute 5: (A = el-salvador-aid)
#   0.26;  0.21  (C=democrat; V=y)
#   0.74;  0.48  (C=republican; V=y)
#   0.96;  0.75  (C=democrat; V=n)
#   0.04;  0.02  (C=republican; V=n)
#   0.80;  0.04  (C=democrat; V=?)
#   0.20;  0.01  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])

    return probabilities_list


def init_attribute6_probabilities():
#  Attribute 6: (A = religious-groups-in-schools)
#   0.45;  0.46  (C=democrat; V=y)
#   0.55;  0.46  (C=republican; V=y)
#   0.89;  0.51  (C=democrat; V=n)
#   0.11;  0.05  (C=republican; V=n)
#   0.82;  0.03  (C=democrat; V=?)
#   0.18;  0.01  (C=republican; V=?)
    probabilities_list = []
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])

    return probabilities_list


def init_attribute7_probabilities():
#  Attribute 7: (A = anti-satellite-test-ban)
#   0.84;  0.75  (C=democrat; V=y)
#   0.16;  0.12  (C=republican; V=y)
#   0.32;  0.22  (C=democrat; V=n)
#   0.68;  0.38  (C=republican; V=n)
#   0.57;  0.03  (C=democrat; V=?)
#   0.43;  0.02  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])

    return probabilities_list

def init_attribute8_probabilities():
#  Attribute 8: (A = aid-to-nicaraguan-contras)
#   0.90;  0.82  (C=democrat; V=y)
#   0.10;  0.07  (C=republican; V=y)
#   0.25;  0.17  (C=democrat; V=n)
#   0.75;  0.41  (C=republican; V=n)
#   0.27;  0.01  (C=democrat; V=?)
#   0.73;  0.03  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])

    return probabilities_list


def init_attribute9_probabilities():
#  Attribute 9: (A = mx-missile)
#   0.91;  0.70  (C=democrat; V=y)
#   0.09;  0.06  (C=republican; V=y)
#   0.29;  0.22  (C=democrat; V=n)
#   0.71;  0.45  (C=republican; V=n)
#   0.86;  0.07  (C=democrat; V=?)
#   0.14;  0.01  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])

    return probabilities_list

def init_attribute10_probabilities():
#  Attribute 10: (A = immigration)
#   0.57;  0.46  (C=democrat; V=y)
#   0.43;  0.28  (C=republican; V=y)
#   0.66;  0.52  (C=democrat; V=n)
#   0.34;  0.23  (C=republican; V=n)
#   0.57;  0.01  (C=democrat; V=?)
#   0.43;  0.01  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])

    return probabilities_list

def init_attribute11_probabilities():
#  Attribute 11: (A = synfuels-corporation-cutback)
#   0.86;  0.48  (C=democrat; V=y)
#   0.14;  0.06  (C=republican; V=y)
#   0.48;  0.47  (C=democrat; V=n)
#   0.52;  0.43  (C=republican; V=n)
#   0.57;  0.04  (C=democrat; V=?)
#   0.43;  0.03  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])

    return probabilities_list

def init_attribute12_probabilities():
#  Attribute 12: (A = education-spending)
#   0.21;  0.13  (C=democrat; V=y)
#   0.79;  0.42  (C=republican; V=y)
#   0.91;  0.80  (C=democrat; V=n)
#   0.09;  0.06  (C=republican; V=n)
#   0.58;  0.07  (C=democrat; V=?)
#   0.42;  0.04  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])

    return probabilities_list

def init_attribute13_probabilities():
#  Attribute 13: (A = superfund-right-to-sue)
#   0.35;  0.27  (C=democrat; V=y)
#   0.65;  0.42  (C=republican; V=y)
#   0.89;  0.67  (C=democrat; V=n)
#   0.11;  0.07  (C=republican; V=n)
#   0.60;  0.06  (C=democrat; V=?)
#   0.40;  0.03  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])
    probabilities_list.append([0., 0.])

    return probabilities_list

def init_attribute14_probabilities():
    #  Attribute 14: (A = crime)
    #   0.36;  0.34  (C=democrat; V=y)
    #   0.64;  0.49  (C=republican; V=y)
    #   0.98;  0.63  (C=democrat; V=n)
    #   0.02;  0.01  (C=republican; V=n)
    #   0.59;  0.04  (C=democrat; V=?)
    #   0.41;  0.02  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0.36, 0.34])
    probabilities_list.append([0.64, 0.49])
    probabilities_list.append([0.98, 0.63])
    probabilities_list.append([0.02, 0.01])
    probabilities_list.append([0.59, 0.04])
    probabilities_list.append([0.41, 0.02])

    return probabilities_list


def init_attribute15_probabilities():
    #  Attribute 15: (A = duty-free-exports)
    #   0.92;  0.60  (C=democrat; V=y)
    #   0.08;  0.04  (C=republican; V=y)
    #   0.39;  0.34  (C=democrat; V=n)
    #   0.61;  0.44  (C=republican; V=n)
    #   0.57;  0.06  (C=democrat; V=?)
    #   0.43;  0.04  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0.92, 0.60])
    probabilities_list.append([0.08, 0.04])
    probabilities_list.append([0.39, 0.34])
    probabilities_list.append([0.61, 0.44])
    probabilities_list.append([0.57, 0.06])
    probabilities_list.append([0.43, 0.04])

    return probabilities_list


def init_attribute16_probabilities():
    #  Attribute 16: (A = export-administration-act-south-africa)
    #   0.64;  0.65  (C=democrat; V=y)
    #   0.36;  0.30  (C=republican; V=y)
    #   0.19;  0.04  (C=democrat; V=n)
    #   0.81;  0.15  (C=republican; V=n)
    #   0.79;  0.31  (C=democrat; V=?)
    #   0.21;  0.07  (C=republican; V=?)

    probabilities_list = []
    probabilities_list.append([0.64, 0.65])
    probabilities_list.append([0.36, 0.30])
    probabilities_list.append([0.19, 0.04])
    probabilities_list.append([0.81, 0.15])
    probabilities_list.append([0.79, 0.31])
    probabilities_list.append([0.21, 0.07])

    return probabilities_list


def init_attributes_probabilities():
    attributes_probabilities = []
    attributes_probabilities.append(init_attribute1_probabilities())
    attributes_probabilities.append(init_attribute2_probabilities())
    attributes_probabilities.append(init_attribute3_probabilities())
    attributes_probabilities.append(init_attribute4_probabilities())
    return attributes_probabilities


def calculate_probability(data, x):
    mean = np.mean(data)
    var = np.var(data)
    p = 1/(math.sqrt(2 * math.pi * var))
    p *= math.exp(-1 * (abs(x) - (mean * mean))) / (2 * var)
    print(p)


def naive_bayees(data_chunks):
    for i in range(len(data_chunks)):
        trainess_data = data_chunks[i]
        test_data = data_chunks[:i] + data_chunks[i+1:len(data_chunks)]


base_data = read_input_csv()
data_chunks = separate_to_chunks(base_data, 10)

print(classes_probabilities)

attributes_probabilities = init_attributes_probabilities()
print(attributes_probabilities)
#naive_bayees(data_chunks)
#calculate_probability([6, 5.92, 5.58, 5.92, 5, 5, 5.42, 5.75], 3)
