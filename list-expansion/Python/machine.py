import sys

# Gets integer value from list of bits
def getValFromBits(bits):
    vals = [2 ** a for a in range(0, len(bits))]
    vals.reverse() # bad
    return sum([a * b for (a, b) in zip(bits, vals)])

# XXX
def LOAD1(operands): # 12 bits as list
    R = operands[:4]
    XY = operands[4:]
    registers[getValFromBits(R)] = memory[getValFromBits(XY)]
    # print('LOAD R' + str(getValFromBits(R)) + ' %.2X' % getValFromBits(XY))

# XXX
def LOAD2(operands):
    R = operands[:4]
    XY = operands[4:]
    registers[getValFromBits(R)] = getValFromBits(XY)
    # print('LOAD\' R' + str(getValFromBits(R)) + ' %.2X' % getValFromBits(XY))

# XXX
def STORE(operands):
    R = operands[:4]
    XY = operands[4:]
    memory[getValFromBits(XY)] = registers[getValFromBits(R)]
    # print('STORE R' + str(getValFromBits(R)) + ' %.2X' % getValFromBits(XY))

# XXX
def MOVE(operands): # first four bits ignored
    R = operands[4:8]
    S = operands[8:]
    registers[getValFromBits(R)] = registers[getValFromBits(S)]
    # print('MOVE R' + str(getValFromBits(R)) + ' S' + str(getValFromBits(S)))

# XXX
def ADD1(operands): # two's complement
    R = operands[:4]
    S = operands[4:8]
    T = operands[8:]
    registers[getValFromBits(R)] = registers[getValFromBits(S)] + registers[getValFromBits(T)]
    # print('ADD R' + str(getValFromBits(R)) + ' S' + str(getValFromBits(S)) +
          # ' T' + str(getValFromBits(T)))

# XXX
def ADD2(operands): # floating-point
    R = operands[:4]
    S = operands[4:8]
    T = operands[8:]
    registers[getValFromBits(R)] = registers[getValFromBits(S)] + registers[getValFromBits(T)]
    # print('ADD\' R' + str(getValFromBits(R)) + ' S' + str(getValFromBits(S)) +
    #       ' T' + str(getValFromBits(T)))

# XXX
def OR(operands):
    R = operands[:4]
    S = operands[4:8]
    T = operands[8:]
    registers[getValFromBits(R)] = registers[getValFromBits(S)] | registers[getValFromBits(T)]
    # print('OR R' + str(getValFromBits(R)) + ' S' + str(getValFromBits(S)) +
    #       ' T' + str(getValFromBits(T)))

# XXX
def AND(operands):
    R = operands[:4]
    S = operands[4:8]
    T = operands[8:]
    registers[getValFromBits(R)] = registers[getValFromBits(S)] & registers[getValFromBits(T)]
    # print('AND R' + str(getValFromBits(R)) + ' S' + str(getValFromBits(S)) +
    #       ' T' + str(getValFromBits(T)))

# XXX
def XOR(operands):
    R = operands[:4]
    S = operands[4:8]
    T = operands[8:]
    registers[getValFromBits(R)] = registers[getValFromBits(S)] ^ registers[getValFromBits(T)]
    # print('XOR R' + str(getValFromBits(R)) + ' S' + str(getValFromBits(S)) +
    #       ' T' + str(getValFromBits(T)))    

# XXX
def ROTATE(operands): # bits 8-12 ignored
    R = operands[:4]
    X = operands[8:]
    print('ROTATE R' + str(getValFromBits(R)) + ' ' + str(getValFromBits(X)))

# XXX
def JUMP(operands):
    R = operands[:4]
    XY = operands[4:]
    if registers[getValFromBits(R)] == registers[0]:
        PC = getValFromBits(XY)
    # print('PC: ' + hex(PC))
    # print('JUMP R' + str(getValFromBits(R)) + ' %.2X' % getValFromBits(XY))

def HALT(operands): # operands unused
    print('HALT')
    sys.exit()

# meta function (not part of Appendix C's machine)
def PRINT(operands):
    R = operands[:4] # register to probe
    XY = operands[4:] # memory cell to probe
    print('R' + str(getValFromBits(R)) +
          ': {:#010b}'.format(registers[getValFromBits(R)]) +
          '\nCell 0x%X' % getValFromBits(XY) +
          ': 0x%X' % memory[getValFromBits(XY)])

# operator v-table
opDict = {0x1: LOAD1, # LOAD R XY (contents)
          0x2: LOAD2, # LOAD R XY (value)
          0x3: STORE, # STORE R XY
          0x4: MOVE,
          0x5: ADD1, # ADD R ST (two's complement)
          0x6: ADD2, # ADD R ST (floating-point)
          0x7: OR,
          0x8: AND,
          0x9: XOR,
          0xA: ROTATE,
          0xB: JUMP,
          0xC: HALT,
          0xD: None,
          0xE: None,
          0xF: PRINT}

# registers 0-F
registers = {x: 0 for x in range(0xF + 1)}
# memory cells 0-255
memory = {x: 0 for x in range(2 ** 8)}

PC = 0x0
SP = 0x0

def operatorToFunction(op): # [list of four elements in {0, 1}]
    opVal = sum([a * b for (a, b) in zip(op, [8, 4, 2, 1])])
    if not(0x1 <= opVal <= 0xF):
        sys.exit('operator doesn\'t exist')
    return opDict[opVal]

def decodeBits(instruction):
    bits = [] # bad
    for bit in format(instruction, '016b'):
        bits.append(bit) # bad
    bits = [int(bit) for bit in bits] # bad
    operator = bits[:4] # first four bits
    operand = bits[4:] # last 12 bits
    func = operatorToFunction(operator)
    func(operand)

if __name__ == '__main__':
    startloc = int(sys.argv[1], 0)
    i = startloc
    for o in sys.argv[2:]:
        memory[i] = int(o, 0)
        i += 1
    for o in memory.values():
        decodeBits(o)
        # if o == 0xC000:
        # print('0x%X' % o)
    # for o in sys.argv[1:]:
    #     decodeBits(int(o, 0))
    # decodeBits(int(sys.argv[-1], 0))
    # print('result: ' + str(registers[int(sys.argv[1])]))
