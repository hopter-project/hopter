import re
import sys

def validate_output(output):
    semaphore_down_pattern = re.compile(r'Down \d')
    semaphore_up_pattern = re.compile(r'Up \d')

    down_count = 0
    max_down = 0

    for line in output.splitlines():
        if semaphore_down_pattern.search(line):
            down_count += 1
            if down_count > max_down:
                max_down = down_count
        elif semaphore_up_pattern.search(line):
            down_count -= 1

    return max_down <= 3


if __name__ == "__main__":
    rust_output = sys.stdin.read()
    
    if validate_output(rust_output):
        print("Test Passed")
    else:
        print("Test Failed")
