from h_lexer import *
import re
from sympy import Symbol, diff, integrate, oo
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
    'statement : VAR "=" term'
    vars[p[1]] = p[3]

def p_expression_vars_with_cln(p):
    '''vars_with_cln : VAR "," VAR
                     | vars_with_cln "," VAR'''

    if type(p[1]) is list:
        p[0] = p[1] + [Symbol(p[3])]
    else:
        p[0] = [Symbol(p[1]), Symbol(p[3])]

def p_expression_num_with_cln(p):
    '''nums_with_cln : NUMBER "," NUMBER
                     | nums_with_cln "," NUMBER'''

    if type(p[1]) is list:
        p[0] = p[1] + [p[3]]
    else:
        p[0] = [p[1], p[3]]

def p_statement_def_func(p):
    'statement : FUNC_VAR "(" VAR ")" "=" term'
    funcs[p[1]] = { 'expr': p[6], 'vars': [Symbol(p[3])] }

def p_statement_def_func2(p):
    'statement : FUNC_VAR "(" vars_with_cln ")" "=" term'
    funcs[p[1]] = { 'expr': p[6], 'vars': p[3] }

def p_statement_eval_func(p):
    'term : FUNC_VAR "(" NUMBER ")"'
    func = funcs[p[1]]
    p[0] = func['expr'].subs(zip(func['vars'], [p[3]]))

def p_statement_eval_func2(p):
    'term : FUNC_VAR "(" nums_with_cln ")"'
    func = funcs[p[1]]
    p[0] = func['expr'].subs(zip(func['vars'], p[3]))

def p_expression_diff_func(p):
    'term : "d" "/" "d" VAR "(" term ")"'
    p[0] = diff(p[6], Symbol(p[4]))

def p_expression_inte_func(p):
    'term : "S" "(" term "d" VAR ")"'
    p[0] = integrate(p[3], Symbol(p[5]))

def p_expression_build_in_func(p):
    'term : BUILD_IN_FUNC "(" term ")"'
    p[0] = p[1](p[3])

def p_expression_constants(p):
    'term : CONSTANTS'
    p[0] = eval(p[1])

def p_statement_expr(p):
    'statement : expression'
    # .replace("*", "")
    output = str(p[1]).replace("**", "^")
    if ("*" in output):
        output = "".join([("(%s)" % x if (len(x) > 1) else x) for x in output.split("*")])

    print(output)

def p_expression_binop(p):
    '''term : term '+' term
            | term '-' term
            | term '*' term
            | term '/' term
            | term '^' term'''
    if p[2] == '+'  : p[0] = p[1] + p[3]
    elif p[2] == '-': p[0] = p[1] - p[3]
    elif p[2] == '*': p[0] = p[1] * p[3]
    elif p[2] == '/': p[0] = p[1] / p[3]
    elif p[2] == '^': p[0] = p[1] ** p[3]

def p_expression_uminus(p):
    "term : '-' term %prec UMINUS"
    p[0] = -p[2]

def p_expression_group(p):
    "term : '(' term ')'"
    p[0] = p[2]

def p_term_number(p):
    "term : NUMBER"
    p[0] = p[1]

def p_term_var(p):
    "term : VAR"
    p[0] = lookupVars(p[1])

def p_term_var_multi(p):
    "term : term VAR"
    p[0] = p[1] * lookupVars(p[2])

def p_expression_term(p):
    "expression : term"
    p[0] = p[1]

def p_expression_func(p):
    "expression : FUNC_VAR"
    p[0] = funcs[p[1]]

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
