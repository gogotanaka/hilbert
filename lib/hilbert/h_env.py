from sympy import Symbol

vars_table = {}
funcs_table = {}

def getVar(var):
    try:
        return vars_table[var]
    except LookupError:
        return Symbol(var)

def setVar(var, val):
    vars_table[var] = val

def getFunc(var):
    return funcs_table[var]

def setFunc(var, func_hash):
    funcs_table[var] = func_hash
