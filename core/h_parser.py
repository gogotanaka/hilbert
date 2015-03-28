from h_lexer import *

precedence = (
    ('left','+','-'),
    ('left','*','/'),
    ('right','UMINUS'),
    )

vars = { }

def lookupVars(var):
    try:
        return vars[var]
    except LookupError:
        print("Undefined name '%s'" % var)

def p_statement_assign(p):
    'statement : VAR "=" expression'
    vars[p[1]] = p[3]

def p_statement_expr(p):
    'statement : expression'
    print(p[1])

def p_expression_binop(p):
    '''expression : expression '+' expression
                  | expression '-' expression
                  | expression '*' expression
                  | expression '/' expression'''
    if p[2] == '+'  : p[0] = p[1] + p[3]
    elif p[2] == '-': p[0] = p[1] - p[3]
    elif p[2] == '*': p[0] = p[1] * p[3]
    elif p[2] == '/': p[0] = p[1] / p[3]

def p_expression_uminus(p):
    "expression : '-' expression %prec UMINUS"
    p[0] = -p[2]

def p_expression_group(p):
    "expression : '(' expression ')'"
    p[0] = p[2]

def p_expression_number(p):
    "expression : NUMBER"
    p[0] = p[1]

def p_expression_var(p):
    "expression : VAR"
    p[0] = lookupVars(p[1])

def p_expression_var_multi(p):
    "expression : VAR_MULTI"
    result = 1
    for c in p[1]: result *= lookupVars(c)
    p[0] = result

def p_error(p):
    if p:
        print("Syntax error at '%s'" % p.value)
    else:
        print("Syntax error at EOF")

import ply.yacc as yacc
yacc.yacc()
parser = yacc
