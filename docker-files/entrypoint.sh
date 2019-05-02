#!/bin/sh

export FLASK_APP=/opt/$PROJECTNAME/main.py


run_server() {
  exec python -m flask run --host=0.0.0.0 --port=8080
}

run_tests() {
  exec python -m pytest tests
}

if [[ $#  -eq 0 ]]; then
  run_server
fi

# Else, process arguments
echo "Full command: $@"
while [[ $# -gt 0 ]]
do
  key="$1"
  echo "Command: ${key}"

  case ${key} in
    run_server)
      run_server
    ;;
    run_tests)
      run_tests
    ;;
  esac
  shift # next argument or value
done

