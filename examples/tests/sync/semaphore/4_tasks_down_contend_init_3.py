import re
import sys

def validate_output(output):
    semaphore_acquired_pattern = re.compile(r'Task \d acquired semaphore')
    semaphore_released_pattern = re.compile(r'Task \d releasing semaphore')

    acquired_count = 0
    max_acquired = 0

    for line in output.splitlines():
        if semaphore_acquired_pattern.search(line):
            acquired_count += 1
            if acquired_count > max_acquired:
                max_acquired = acquired_count
        elif semaphore_released_pattern.search(line):
            acquired_count -= 1

    return max_acquired <= 3

if __name__ == "__main__":
    rust_output = sys.stdin.read()
    
    if validate_output(rust_output):
        print("Test Passed")
    else:
        print("Test Failed")
