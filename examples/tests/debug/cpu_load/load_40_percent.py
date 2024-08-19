import sys

def validate_output(output):
    # A line looks like: "CPU load xx.x%"
    for line in output.splitlines():
        percentage = float(line.split(' ')[2][:-1])
        if percentage > 45 or percentage < 35:
            print("Test Failed")
            sys.exit(1)
        
    print("Test Passed")


if __name__ == "__main__":
    validate_output(sys.stdin.read())
