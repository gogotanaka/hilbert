
from sly import Parser
from hilbert.CalcLexer import CalcLexer
from hilbert.CalcEnv import CalcEnv
import hilbert.decorator as decorator
import math
from sympy import sin, cos, tan, log, exp, pi, oo, I, diff, Symbol, integrate, limit

class CalcParser(Parser):
    tokens = CalcLexer.tokens

    precedence = (
        ('left', PLUS, MINUS),
        ('left', TIMES, DIVIDE),
        ('right', UMINUS)
        )

    def __init__(self):
        self.env = CalcEnv()

    def makeList(self, term_or_terms):
        if isinstance((term_or_terms), list):
            return term_or_terms
        else:
            return [term_or_terms]

    @_('VAR "=" expr')
    def statement(self, p):
        self.env.setVar(p.VAR, p.expr)

    @_('FUNC_VAR "(" expr ")" "=" expr')
    def statement(self, p):
        self.env.setFunc(p.FUNC_VAR, { 'expr': p.expr1, 'vars': self.makeList(p.expr0) })

    @_('expr')
    def statement(self, p):
        print(decorator.call(p.expr))

    @_('expr PLUS expr')
    def expr(self, p):
        return p.expr0 + p.expr1

    @_('expr MINUS expr')
    def expr(self, p):
        return p.expr0 - p.expr1

    @_('expr TIMES expr')
    def expr(self, p):
        return p.expr0 * p.expr1

    @_('expr DIVIDE expr')
    def expr(self, p):
        return p.expr0 / p.expr1

    @_('expr EXPO expr')
    def expr(self, p):
        return p.expr0 ** p.expr1

    @_('MINUS expr %prec UMINUS')
    def expr(self, p):
        return -p.expr

    @_('FUNC_VAR "(" expr ")"')
    def expr(self, p):
        func = self.env.getFunc(p.FUNC_VAR)
        return func['expr'].subs(zip(func['vars'], self.makeList(p.expr)))

    @_('"(" expr ")"')
    def expr(self, p):
        return p.expr

    @_('BUILD_IN_FUNC_VAR "(" expr ")"')
    def expr(self, p):
        return eval(p.BUILD_IN_FUNC_VAR)(p.expr)

    @_('NUMBER')
    def expr(self, p):
        return int(p.NUMBER)

    @_('CONSTANT')
    def expr(self, p):
        match p.CONSTANT:
            case 'oo':
                return oo
            case 'e':
                return exp(1)
            case 'i':
                return I
            case 'pi':
                return pi
            case _:
                print("ERROR")

    @_('VAR')
    def expr(self, p):
        return self.env.getVar(p.VAR)
    
    @_('expr VAR')
    def expr(self, p):
        return p.expr * self.env.getVar(p.VAR)

    @_('"d" DIVIDE "d" VAR "(" expr ")"')
    def expr(self, p):
        return diff(p.expr, Symbol(p.VAR))

    @_('"d" FUNC_VAR DIVIDE "d" VAR')
    def expr(self, p):
        return diff(self.env.getFunc(p.FUNC_VAR)['expr'], Symbol(p.VAR))

    @_('"S" "(" expr "d" VAR ")"')
    def expr(self, p):
        return integrate(p.expr, Symbol(p.VAR))

    @_('"S" "(" FUNC_VAR "d" VAR ")"')
    def expr(self, p):
        return integrate(self.env.getFunc(p.FUNC_VAR)['expr'], Symbol(p.VAR))

    @_("LIMIT_SYM '[' expr R_ARROW expr ']' '(' expr ')'")
    def expr(self, p):
        return limit(p.expr2, p.expr0, p.expr1)

    @_('expr "," expr')
    def expr(self, p):
        return [p.expr0] + self.makeList(p.expr1)

    @_('CONSTANT "=" expr')
    def statement(self, p):
        print("Can't assign new value on constant")
