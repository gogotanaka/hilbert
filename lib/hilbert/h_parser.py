from h_lexer import *
import re
import h_env
from sympy import Symbol, diff, integrate, oo, exp, limit, core, pi

precedence = (
    ('left','+','-'),
    ('left','*','/'),
    ('right','UMINUS'),
    )

def wrapTerm(term_or_terms):
    if type(term_or_terms) is list:
        return term_or_terms
    else:
        return [term_or_terms]

def p_statement_expr(p):
    'statement : expression'
    output = p[1]

    if isinstance(output, (int, float, complex)):
        if (int(output) == output):
            output = int(output)
        else:
            output = round(float(output), 8)


    output = str(output).replace("**", "^")
    if ("*" in output):
        output = "".join([("(%s)" % x if (len(x) > 1) else x) for x in output.split("*")])

    output = output.replace("E", "e")
    output = re.sub(r"exp\((.+)\)", r"e^\1", output)
    print(str(output))

def p_statement_assign(p):
    'statement : VAR "=" term'
    h_env.setVar(p[1], p[3])

def p_statement_def_func(p):
    '''statement : FUNC_VAR "(" term ")" "=" term
                 | FUNC_VAR "(" terms_with_cln ")" "=" term'''

    h_env.setFunc(p[1], { 'expr': p[6], 'vars': wrapTerm(p[3]) })

def p_expression_term(p):
    "expression : term"
    p[0] = p[1]

def p_expression_func(p):
    "expression : FUNC_VAR"
    p[0] = h_env.getFunc(p[1])

def p_term_eval_func(p):
    '''term : FUNC_VAR "(" term ")"
            | FUNC_VAR "(" terms_with_cln ")"'''

    func = h_env.getFunc(p[1])
    p[0] = func['expr'].subs(zip(func['vars'], wrapTerm(p[3])))

def p_term_diff_func(p):
    'term : "d" "/" "d" VAR "(" term ")"'
    p[0] = diff(p[6], Symbol(p[4]))

def p_term_diff_direct_func(p):
    'term : "d" FUNC_VAR "/" "d" VAR'
    p[0] = diff(h_env.getFunc(p[2])['expr'], Symbol(p[5]))

def p_term_inte_func(p):
    'term : "S" "(" term "d" VAR ")"'
    p[0] = integrate(p[3], Symbol(p[5]))

def p_term_inte_direct_func(p):
    'term : "S" "(" FUNC_VAR "d" VAR ")"'
    p[0] = integrate(h_env.getFunc(p[3])['expr'], Symbol(p[5]))

def p_term_build_in_func(p):
    'term : BUILD_IN_FUNC "(" term ")"'
    p[0] = p[1](p[3])

def p_term_constants(p):
    'term : CONSTANTS'
    p[0] = (exp(1) if p[1] == 'e' else eval(p[1]))

def p_term_binop(p):
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

def p_term_uminus(p):
    "term : '-' term %prec UMINUS"
    p[0] = -p[2]

# def p_term_group(p):
#     "term : '(' term ')'"
#     p[0] = p[2]

def p_term_number(p):
    "term : NUMBER"
    p[0] = p[1]

def p_term_var(p):
    "term : VAR"
    p[0] = h_env.getVar(p[1])

def p_term_var_multi(p):
    "term : term VAR"
    p[0] = p[1] * h_env.getVar(p[2])

def p_term_limit(p):
    "term : LIMIT_SYM '[' term R_ARROW term ']' '(' term ')'"
    p[0] = limit(p[8], p[3], p[5])

def p_terms_with_cln(p):
    '''terms_with_cln : term "," term
                      | terms_with_cln "," term'''

    p[0] = wrapTerm(p[1]) + [p[3]]

def p_error(p):
    if p:
        print("Syntax error at '%s'" % p.value)
    else:
        print("Syntax error at EOF")

import ply.yacc as yacc
yacc.yacc()
parser = yacc
