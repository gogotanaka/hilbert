from sympy import Symbol

class CalcEnv():
    def __init__(self):
        self.vars_table = { }
        self.funcs_table = { }

    def getVar(self, var):
        try:
            return self.vars_table[var]
        except LookupError:
            return Symbol(var)

    def setVar(self, var, val):
        self.vars_table[var] = val

    def getFunc(self, var):
        return self.funcs_table[var]

    def setFunc(self, var, func_hash):
        self.funcs_table[var] = func_hash
