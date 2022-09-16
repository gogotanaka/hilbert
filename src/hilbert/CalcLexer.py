
from sly import Lexer

class CalcLexer(Lexer):
    literals = [ '(',')', '=', 'd', 'S', ',', '[', ']']
    tokens = {
        VAR,
        NUMBER,
        CONSTANT,

        PLUS,
        TIMES,
        MINUS,
        DIVIDE,
        EXPO,

        FUNC_VAR,
        BUILD_IN_FUNC_VAR,

        LIMIT_SYM,
        R_ARROW
    }
    ignore = ' \t'

    # Tokens
    VAR = r'(?!(sin|cos|tan|log|oo|pi|lim))[abcjklmnpqrstuvwxyz]'
    NUMBER = r'\d+'
    CONSTANT = r'(oo|pi|e|i)'
    LIMIT_SYM = r'lim'
    R_ARROW = r'->'

    # Special symbols
    PLUS = r'\+'
    MINUS = r'-'
    TIMES = r'\*'
    DIVIDE = r'/'
    EXPO = r'\^'
  
    FUNC_VAR = r'[f-h]'
    BUILD_IN_FUNC_VAR = '(sin|cos|tan|log)'

    # Ignored pattern
    ignore_newline = r'\n+'

    # Extra action for newlines
    def ignore_newline(self, t):
        self.lineno += t.value.count('\n')

    def error(self, t):
        print("Illegal character '%s'" % t.value[0])
        self.index += 1
