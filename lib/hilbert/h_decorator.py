import re
def execute(output):
    output = str(output).replace("**", "^")
    if ("*" in output):
        output = "".join([("(%s)" % x if (len(x) > 1) else x) for x in output.split("*")])

    output = output.replace("E", "e")
    output = re.sub(r"exp\((.+)\)", r"e^\1", output)
    return output
