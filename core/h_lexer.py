tokens = (
    'VAR',
    'NUMBER',
    'VAR_MULTI'
)

literals = ['=','+','-','*','/', '(',')']


t_VAR = r'[a-z]'
t_VAR_MULTI = r'[a-z][a-z]+'

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
