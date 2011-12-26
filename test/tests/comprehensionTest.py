# List Comprehension Tests
print [x * 2 for x in [3, 4, 5]]
print [5 * y for y in range(3)]

mat = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
       ]
print [[row[i] for row in mat] for i in [0, 1, 2]]
print [x + y + z for x, y, z in [(5, 6, 2), (7, 8, 1)]]

seq1 = ['a', 'b', 'c']
seq2 = [1, 2, 3]
[(x, y) for x in seq1 for y in seq2]

# Dictionary Comprehension Tests
print {x: x + 2 for x in [5, 6, 7]}
print {x: y ** x for x, y in [(3, 2), (4, 5)]}
print {x: x + x for x, y in [('hello', 5), ('jello', 2)]}
print {x: x + 2 for x in [5, 67, 2]}
k = 4
print {x: x + k for x in [5, 67, 2]}
print {x: y + z for x, y, z in [(5, 2, 7), (8, 9, 4)]}
