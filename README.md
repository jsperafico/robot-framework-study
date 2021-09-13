# robot-framework-study

Please make sure that you have Python3 installed at your machine.
Once you have it, run `pip install -r requirements.txt`.

# How to run this project:

Open this folder on your terminal and use: 

`robot -d ${PATH_OF_EXECUTION_OUTPUT} ${PATH_TO_YOUR_ROBOT_TEST_FILE} `

Replacing:
- PATH_TO_YOUR_ROBOT_TEST_FILE: relative path to your robot test file. (E.g. `atest\sample\tests.robot`)
- PATH_OF_EXECUTION_OUTPUT: relative|absolute path where the execution output should be stored. (E.g. `output\sample`)
