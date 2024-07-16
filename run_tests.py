import os
import sys
import pathlib
import subprocess
from tqdm import tqdm

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

            # Check that each test case is accompanied by a txt file or a python file
            # as the groundtruth output answer.
            for file_rs_ext in rust_files:
                file_no_ext = os.path.basename(file_rs_ext)[:-3]
                file_txt_ext = file_no_ext + '.txt'
                file_py_ext = file_no_ext + '.py'
                assert(file_txt_ext in answer_files or file_py_ext in answer_files)

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
    return tests

def main():
    # Get all test cases under ./examples/tests/
    tests = enumerate_tests()

    for (category, subcategory, file_no_ext), answer in tqdm(tests):
        # Run the test case with `cargo run --example`
        test_case_output = subprocess.run([
                    'cargo', 'run', '--release',
                    '--example', f'test-{category}-{subcategory}-{file_no_ext}'
                ], capture_output=True).stdout
        
        # If the groundtruth is provided by a .txt file, compare the output against it.
        if answer.endswith('.txt'):
            with open(answer, 'rb') as f:
                answer = f.read()
            if answer != test_case_output:
                print(
                    f'Error: Test case {category}-{subcategory}-{file_no_ext} failed.',
                    file=sys.stderr
                )
                sys.exit(1)
        
        # If the output is to be examined by a python script, run the script.
        elif answer.endswith('.py'):
            decision = subprocess.run(['python', answer], input=test_case_output, capture_output=True).stdout
            if decision != 'Test Passed\n'.encode('utf-8'):
                print(
                    f'Error: Test case {category}-{subcategory}-{file_no_ext} failed.',
                    file=sys.stderr
                )
                sys.exit(1)


if __name__ == '__main__':
    main()
