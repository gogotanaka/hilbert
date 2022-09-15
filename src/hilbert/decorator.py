import re
def call(output):
    output = str(output).replace("**", "^")
    # exp(x) => e^x
    output = re.sub(r"exp\((.+)\)", r"e^\1", output)
    # e^1 => e
    output = re.sub(r"(.+)\^1", r"\1", output)

    if ("*" in output):
        def func(s):
            if len(s) == 1:
                return s
            elif ("^" in output):
                return "(%s)" % s
            else:
                return s
        chars = list(map(func, output.split("*")))
        output = "".join(chars)

    output = output.replace("E", "e")
    # y^2/3 -> y^(2/3)
    # output = re.sub(r"(.+)\^(.+\/.+) \+", r"\1^(\2)", output)
    return output
