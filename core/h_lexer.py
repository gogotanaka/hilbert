tokens = (
    'VAR',
    'FUNC_VARS',
    'FUNC_SUBS',
    'NUMBER',
    'VAR_MULTI',
    'DIFF_SYM'
)

literals = ['=','+','-','*','/', '(',')', 'f']

t_VAR = r'[a-ceg-z]'
t_DIFF_SYM = r'd\/d[a-ceg-z]'
t_FUNC_VARS = r'\(x\)'
t_FUNC_SUBS = r'\([0-9]\)'
t_VAR_MULTI = r'[a-ceg-z][a-ceg-z]+'


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
