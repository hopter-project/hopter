import os
import sys
import pathlib
import subprocess
from tqdm import tqdm

def run_openocd():
    # Run openocd command in a separate process
    openocd_process = subprocess.Popen(
        ['openocd', '-f', 'interface/stlink.cfg', '-f', 'target/stm32f4x.cfg'],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    
    for line in iter(openocd_process.stderr.readline, ''):
        if "Listening on port 3333 for gdb connections" in line:
            break
    else:
        print("Failed to detect OpenOCD connection.")
        sys.exit(1)
        
    return openocd_process

import subprocess

def run_gdb(category, subcategory, file_no_ext):
    # Run gdb command in a separate process using multiple -ex options
    gdb_process = subprocess.Popen(
        ['arm-none-eabi-gdb', '-q',
         f'target/thumbv7em-none-eabihf/release/examples/test-{category}-{subcategory}-{file_no_ext}',
         '-ex', 'target extended-remote :3333',
         '-ex', 'set print asm-demangle on',
         '-ex', 'monitor arm semihosting enable',
         '-ex', 'load',
         '-ex', 'continue'],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )

    return gdb_process

def monitor_output(openocd_process, gdb_process):
    # Monitor OpenOCD's output
    output = []
    while True:
        line = openocd_process.stdout.readline()  # Blocking read until output is available
        if not line:  # If no line is read, end of process or error
            print("OpenOCD process ended or error occurred.")
            break
        
        if 'test complete!' in line:
            openocd_process.terminate()
            gdb_process.terminate()
            break
        
        output.append(line)
    
    # Join the output list into a single string
    return ''.join(output)

def enumerate_tests():
    repo_path = pathlib.Path(__file__).parent.resolve()
    all_tests_path = os.path.join(repo_path, 'examples/tests')

    tests = []

    for category in os.listdir(all_tests_path):
        category_path = os.path.join(all_tests_path, category)

        for subcategory in os.listdir(category_path):
            subcategory_path = os.path.join(category_path, subcategory)

            test_files = os.listdir(subcategory_path)
            rust_files = [file for file in test_files if file.endswith('.rs')]
            answer_files = [file for file in test_files if file.endswith('.py') or file.endswith('.txt')]

            for file_rs_ext in rust_files:
                file_no_ext = os.path.basename(file_rs_ext)[:-3]
                file_txt_ext = file_no_ext + '.txt'
                file_py_ext = file_no_ext + '.py'

                if file_txt_ext in answer_files:
                    tests.append((
                        (category, subcategory, file_no_ext),
                        os.path.join(subcategory_path, file_txt_ext)
                    ))
                elif file_py_ext in answer_files:
                    tests.append((
                        (category, subcategory, file_no_ext),
                        os.path.join(subcategory_path, file_py_ext)
                    ))
                else:
                    print(
                        f'Error: Test file {category}-{subcategory}-{file_rs_ext} does not have an answer file.',
                        file=sys.stderr
                    )
                    sys.exit(1)
    return tests

def main():
    if len(sys.argv) != 2:
        print(f'Usage: python {sys.argv[0]} <features>')
        sys.exit(1)
    
    features = sys.argv[1]
    
    # Get all test cases under ./examples/tests/
    tests = enumerate_tests()

    for (category, subcategory, file_no_ext), answer in tqdm(tests):
        # Build the test case with `cargo build --example`
        build_result = subprocess.run([
            'cargo', 'build', 
            '--features', features,
            '--release',
            '--example', f'test-{category}-{subcategory}-{file_no_ext}'
        ], capture_output=True)

        if build_result.returncode != 0:
            print(
                f'Error: Test case {category}-{subcategory}-{file_no_ext} failed to build.',
                file=sys.stderr
            )
            print('Output from stdout:', file=sys.stderr)
            print(str(build_result.stdout, encoding='utf-8'))
            print('Output from stderr:', file=sys.stderr)
            print(str(build_result.stderr, encoding='utf-8'))
            exit(1)

        # Run OpenOCD and GDB in parallel
        openocd_process = run_openocd()
        gdb_process = run_gdb(category, subcategory, file_no_ext)

        # Monitor OpenOCD output in a separate thread
        output = monitor_output(openocd_process, gdb_process)

        # Check the output from OpenOCD against the expected results
        if answer.endswith('.txt'):
            with open(answer, 'rb') as f:
                answer = f.read().decode('utf-8')
            if answer != output:
                print(
                    f'Error: Test case {category}-{subcategory}-{file_no_ext} failed to provide correct output.\nExpeted:\n{answer}\nGot:\n{output}',
                    file=sys.stderr
                )
                # sys.exit(1)

        elif answer.endswith('.py'):
            decision = subprocess.run(['python', answer], input=output.encode('utf-8'), capture_output=True).stdout
            if decision != 'Test Passed\n'.encode('utf-8'):
                print(
                    f'Error: Test case {category}-{subcategory}-{file_no_ext} failed.\nExpeted:\n{answer}\nGot:\n{output}',
                    file=sys.stderr
                )
                # sys.exit(1)

if __name__ == '__main__':
    main()