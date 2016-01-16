import sys
import collections
from machine import internals
from machine import util

opop = collections.namedtuple('OpOp', ['operator', 'operand'])

def fetch():
    """
Receives next instruction and sets PC to it.
    """
    pass

def execute(oo):
    """
Takes an OpOp (oo), and applies operator to operand.
    """
    oo.operator(oo.operand)

# This should be the "Decode" of FDE, and nothing more.
def decode(instruction):
    bits = [] # bad
    for bit in format(instruction, '016b'): # bad (?)
        bits.append(bit) # bad
    bits = [int(bit) for bit in bits] # bad
    operator = bits[:4] # first four bits
    operand = bits[4:] # last 12 bits
    return opop(internals.opDict[util.operatorToFunction(operator)], operand)
    
if __name__ == '__main__':
    startloc = int(sys.argv[1], 0)
    i = startloc
    for o in sys.argv[2:]:
        internals.memory[i] = int(o, 0)
        i += 1
    for o in internals.memory.values():
        execute(decode(o))
