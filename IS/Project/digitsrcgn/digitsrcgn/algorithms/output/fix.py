
import csv
data = []

with open('knn.csv', 'r') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    for row in reader:
        if row != []:
                data.append(row)

with open('knn-fixed.csv', 'wb') as csvfile:
    output = csv.writer(csvfile, delimiter=',')
    output.writerow(['ImageId', 'Label'])

    for i in range(1, len(data)):
        output.writerow([i, data[i][1]])