#!/bin/bash

# script will:
#  - check if config exists. 
#     - if false sets org, bucket, username, and password.
#  - check if token exists. 
#     - if false generates & prints a new api token
#  - check if sample datasets exist.
#     - if false rebuild the core datasets (noaa buoy etc)

function initialInfluxSetup() {
  printf "\n%b\n\n" "1 of 3: attempting to run initial setup..."
  SETUP="$(influx setup \
    --org 'grafana' \
    --bucket 'grafana' \
    --username "${INFLUXDB_ADMIN_USER}" \
    --password "${INFLUXDB_ADMIN_PASSWORD}" \
    --force)"

  if [[ -n ${SETUP} ]]; then
    printf "%b\n" "initial setup will now run:"
    printf "\n%b\n\n" "${SETUP}\n\nPassword\n${INFLUXDB_ADMIN_PASSWORD}"
  else
    printf "\n%b\n\n" "initial setup did not run"
  fi
}

function checkForToken() {
  printf "%b\n\n" "2 of 3: checking if user grot has an api token..."
  INFLUX_TOKEN="$(influx auth list --json | grep 'token' -B 2 -A 3 )"
    # or ... | jq -r '.[] | select(.userName == "grot").token')"

  if [[ -n "${INFLUX_TOKEN}" ]]; then
    printf "%b\n\n" "token exists:\n\n${INFLUX_TOKEN}"
  else 
    printf "%b\n\n" "token does not appear to exist. making one now...'"
    getNewToken
  fi
}

function getNewToken() {
  INFLUX_TOKEN="$(influx auth create \
    --all-access \
    --description "grot-$(date +'%Y-%m-%d')" \
    --json)"

  if [[ -n "${INFLUX_TOKEN}" ]]; then
    printf "\n%b\n\n" "token created:\n\n${INFLUX_TOKEN}"
  else
    printf "\n%b\n\n" "something went wrong making a token:\n\n${INFLUX_TOKEN}"
  fi
}

function checkForDatasets() {
  printf "%b\n" "3 of 3: checking for database and datasets..."
  TASKCHECK="$(influx task list --json)"
  # hard-coded for now
  TASKLIST=(
  'noaa-buoys'
  'usgs-earthquakes' 
  'noaa-water-sample'
  )

  for i in "${TASKLIST[@]}"
  do
    printf "%b\n" "setting up dataset: $i"
    if ! [[ ${TASKCHECK} =~ $i ]]; then
      makeBucket "$i"
      makeTask "$i"
    fi
  done
}

function makeBucket() {
  if [[ $i =~ noaa-water-sample ]]; then
    BUCKET="$(influx bucket create --name "${1}")"
    printf "\n%b\n\n" "creating bucket:\n\n${BUCKET}"
  else
    BUCKET="$(influx bucket create --name "${1}" --retention "30d")"
    printf "\n%b\n\n" "creating bucket:\n\n${BUCKET}"
  fi
}

function makeTask() {
  TASK="$(influx task create --file "/scripts/${1}.flux")"
  printf "\n%b\n\n" "creating task:\n\n${TASK}"
}

initialInfluxSetup
checkForToken
checkForDatasets
