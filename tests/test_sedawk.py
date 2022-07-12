import filecmp
from subprocess import check_output, CalledProcessError


script_path = './sedawk.sh'

def run_shell_test(script):
    out = check_output([script], universal_newlines=True)
    return out.split("\n")[0]

def test_script_working():
    failed = False

    try:
        result = run_shell_test(script_path)
    except CalledProcessError as e:
        failed = True
        result = e.output
    assert failed == False

def test_sedawk():

    try:
        result = run_shell_test(script_path)
    except CalledProcessError as e:
        print(e.output)

    assert filecmp.cmp('passwd_new', './tests/passwd_result') == True
