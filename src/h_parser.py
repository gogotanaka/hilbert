from h_lexer import *
import re
from sympy import Symbol, diff, integrate, sin, cos, tan, log, oo
from math import e, pi

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

def p_expression_vars_with_cln(p):
    'vars_with_cln : VAR "," VAR'
    p[0] = [Symbol(p[1]), Symbol(p[3])]

def p_expression_num_with_cln(p):
    'nums_with_cln : NUMBER "," NUMBER'
    p[0] = [p[1], p[3]]

def p_statement_def_func(p):
    'statement : FUNC_VAR "(" VAR ")" "=" expression'
    funcs[p[1]] = { 'expr': p[6], 'vars': [Symbol(p[3])] }

def p_statement_def_func2(p):
    'statement : FUNC_VAR "(" vars_with_cln ")" "=" expression'
    funcs[p[1]] = { 'expr': p[6], 'vars': p[3] }

def p_statement_eval_func(p):
    'expression : FUNC_VAR "(" NUMBER ")"'
    func = funcs[p[1]]
    p[0] = func['expr'].subs(zip(func['vars'], [p[3]]))

def p_statement_eval_func2(p):
    'expression : FUNC_VAR "(" nums_with_cln ")"'
    func = funcs[p[1]]
    p[0] = func['expr'].subs(zip(func['vars'], p[3]))

def p_expression_diff_func(p):
    'expression : DIFF_SYM "(" expression ")"'
    p[0] = diff(p[3], Symbol(p[1].replace('d/d', '')))

def p_expression_inte_func(p):
    'expression : INTE_SYM "(" expression INTE_D_DYM ")"'
    x = Symbol(p[4].replace('d', ''))
    p[0] = integrate(p[3], x)

def p_expression_build_in_func(p):
    'expression : BUILD_IN_FUNC "(" VAR ")"'
    func = eval(p[1])
    p[0] = func(p[3])

def p_expression_constants(p):
    'expression : CONSTANTS'
    p[0] = eval(p[1])

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
    "expression : expression VAR"
    p[0] = p[1] * lookupVars(p[2])

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
