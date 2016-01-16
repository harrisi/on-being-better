import sys

# Gets integer value from list of bits
def getValFromBits(bits):
    vals = [2 ** a for a in range(0, len(bits))]
    vals.reverse() # bad
    return sum([a * b for (a, b) in zip(bits, vals)])

def operatorToFunction(op): # [list of four elements in {0, 1}]
    opVal = sum([a * b for (a, b) in zip(op, [8, 4, 2, 1])])
    if not(0x1 <= opVal <= 0xF):
        sys.exit('operator doesn\'t exist')
    return opVal
