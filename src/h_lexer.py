tokens = (
    'VAR',
    # 'VARS_WITH_CLN',
    # 'NUMS_WITH_CLN',
    'FUNC_VAR',
    'NUMBER',
    'VAR_MULTI',
    'DIFF_SYM',
    'INTE_SYM',
    'INTE_D_DYM',
    'BUILD_IN_FUNC',
    'CONSTANTS'
)

literals = ['=','+','-','*','/', '^', '(',')', ',']

var = r'(?!(sin|cos|tan|log|oo|e|pi))[abcijklmnpqrstuvwxyz]'
t_VAR = r'{0}'.format(var)
# t_VARS_WITH_CLN = r'{0},{0}'.format(var)
# t_NUMS_WITH_CLN = r'\d+(, *\d)+'
t_FUNC_VAR = r'[f-h]'
t_DIFF_SYM = r'd\/d{0}'.format(var)
t_INTE_SYM = r'S'
t_INTE_D_DYM = r' d{0}'.format(var)
t_BUILD_IN_FUNC = r'(sin|cos|tan|log)'
t_VAR_MULTI = r'{0}{0}+'.format(var)
t_CONSTANTS = r'(oo|e|pi)'

# a, b, c, j, k, ... z:
# f, g, h:
# e:

def t_NUMBER(t):
    r'\d+'
    t.value = int(t.value)
    return t

t_ignore = " \t"

def t_newline(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")

def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

import ply.lex as lex
lex.lex()
