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
    if len(sys.argv) != 2:
        print("Usage: python multiple_tasks.py <path_to_output_file>")
        sys.exit(1)

    output_file_path = sys.argv[1]

    try:
        with open(output_file_path, "r") as file:
            rust_output = file.read()
    except FileNotFoundError:
        print(f"File not found: {output_file_path}")
        sys.exit(1)

    
    if validate_output(rust_output):
        print("Test Passed")
    else:
        print("Test Failed")
