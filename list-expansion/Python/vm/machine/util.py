import sys
import re
import os
# from machine import registers

# Gets integer value from list of bits
def getValFromBits(bits):
    vals = [2 ** a for a in range(0, len(bits))]
    vals.reverse() # bad
    return sum([a * b for (a, b) in zip(bits, vals)])

def operatorToFunction(op): # [list of four elements in {0, 1}]
    opVal = sum([a * b for (a, b) in zip(op, [8, 4, 2, 1])])
    if not(0x1 <= opVal <= 0xD):
        sys.exit('operator doesn\'t exist')
    return opVal

def readFromFile(loc):
    res = []
    with open(loc, 'r') as f:
        for line in f:
            line = re.sub(';;.*', '', line)
            line = re.sub('[\s+]', '', line)
            if line:
                res.append(line[:2])
                res.append(line[2:])
    return res

def intToBits(val, b=8):
    """
    Returns list of binary data representing integer value.
    """
    bits = [] # bad
    for bit in format(val, '0' + str(b) + 'b'): # bad (?)
        bits.append(bit)
    return [int(bit) for bit in bits] # bad

# This should be merged with readFromFile from above.
def readAsm(loc):
    res = []
    with open(loc, 'r') as f:
        for line in f:
            line = re.sub(';;.*', '', line)
            inRes = []
            for word in line.split():
                inRes.append(word)
            if inRes:
                res.append(inRes)
    return res

# XXX
# BAD
asmDict = {'LOAD': 0x1,
           'LOADV': 0x2,
           'STORE': 0x3,
           'MOVE': 0x4,
           'ADD': 0x5,
           'ADDF': 0x6,
           'OR': 0x7,
           'AND': 0x8,
           'XOR': 0x9,
           'ROTATE': 0xA,
           'JUMP': 0xB,
           'HALT': 0xC,
           'PRINT': 0xD}

def spitMachine(asm, asmFile='out.iasm'):
    res = []
    out = ''
    orig = ''
    openType = 'w' if os.path.isfile(asmFile) else 'a'
    with open(asmFile, openType) as f:
        for i in asm:
            for j in i:
                if j in asmDict:
                    res.append(hex(asmDict[j])[2:])
                else:
                    try:
                        res.append(format(int(j, 0), '{:#04x}')[2:])
                    except ValueError:
                        match = re.search('[0-9a-fA-F]+', j)
                        if match:
                            res.append(match.group())
            for item in res:
                if not(item in 'cC'):
                    out = out + item.upper()
                else:
                    out = out + item.upper() + '000'
            for item in i:
                orig = orig + ' ' + item
            orig = orig.strip()
            f.write(out + ' ;; ' + orig + '\n')
            res.clear()
            out = ''
            orig = ''

def safeSet(storage, key, value):
    storage[key] = value[-(storage.bits):]

def twosComplement(val, length=8):
    bits = intToBits(val, length)
    res = []
    swap = False
    if bits[0] == 0:
        return val
    for i in bits[::-1]:
        if swap:
            if i is 0:
                res.insert(0, 1)
                continue
            else:
                res.insert(0, 0)
                continue
        if i is 0:
            res.insert(0, i)
        else:
            res.insert(0, i)
            swap = True
    return -(getValFromBits(res))
