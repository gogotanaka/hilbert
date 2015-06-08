from h_lexer import *
import re
from sympy import Symbol, diff, integrate

precedence = (
    ('left','+','-'),
    ('left','*','/'),
    ('right','UMINUS'),
    )

vars = {}
funcs = {}

def lookupVars(var):
    try:
        return vars[var]
    except LookupError:
        return Symbol(var)

def p_statement_assign(p):
    'statement : VAR "=" expression'
    vars[p[1]] = p[3]

def p_statement_def_func(p):
    'statement : FUNC_VAR "(" VAR ")" "=" expression'
    funcs[p[1]] = { 'expr': p[6], 'vars': [Symbol(v) for v in re.split(r', *', p[3])] }

def p_statement_eval_func(p):
    'expression : FUNC_VAR "(" NUMBER ")"'
    func = funcs[p[1]]
    p[0] = func['expr'].subs(zip(func['vars'], [p[3]]))

def p_expression_diff_func(p):
    'expression : DIFF_SYM "(" expression ")"'
    p[0] = diff(p[3], Symbol(p[1].replace('d/d', '')))

def p_expression_inte_func(p):
    'expression : INTE_SYM "(" expression INTE_D_DYM ")"'
    x = Symbol(p[4].replace('d', ''))
    p[0] = integrate(p[3], x)

def p_expression_build_in_func(p):
    'expression : BUILD_IN_FUNC'
    p[0] = 1

def p_statement_expr(p):
    'statement : expression'
    print(p[1])

def p_expression_binop(p):
    '''expression : expression '+' expression
                  | expression '-' expression
                  | expression '*' expression
                  | expression '/' expression
                  | expression '^' expression'''
    if p[2] == '+'  : p[0] = p[1] + p[3]
    elif p[2] == '-': p[0] = p[1] - p[3]
    elif p[2] == '*': p[0] = p[1] * p[3]
    elif p[2] == '/': p[0] = p[1] / p[3]
    elif p[2] == '^': p[0] = p[1] ** p[3]

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

# def p_expression_eval_py(p):
#     'expression : EVAL_PY'
#     print(p[1])
#     exec(re.sub(r'py:', '', p[1]))

# def p_statement_def_func(p):
#     'statement : DEF_FUNC'
#     a = "def %s" % re.sub(r' *= *', ': return ', p[1])
#     print(a)
#     exec(a)
#
# def p_expression_eval_func(p):
#     'expression : EVAL_FUNC'
#     print("Syntax error at")
#     eval(1)

def p_error(p):
    if p:
        print("Syntax error at '%s'" % p.value)
    else:
        print("Syntax error at EOF")

import ply.yacc as yacc
yacc.yacc()
parser = yacc
