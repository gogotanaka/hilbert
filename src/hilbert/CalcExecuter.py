from hilbert.CalcLexer import CalcLexer
from hilbert.CalcParser import CalcParser

class CalcExecuter:
    def __init__(self):
        self.lexer = CalcLexer()
        self.parser = CalcParser()

    def call(self, text):
        self.parser.parse(self.lexer.tokenize(text))
