#!/bin/bash 

ENV_MODE=$1

if [[ "$ENV_MODE" == "dev" ]]
then
    ENV_FILE=".env.dev"
else
    ENV_FILE=".env"
fi

RUN_COMMAND="flutter run"

while IFS= read -r line || [[ -n "$line" ]];
do
    if ! [[ $line == *"#"* ]]; 
    then
        RUN_COMMAND="$RUN_COMMAND --dart-define $line"
    fi
done < "$ENV_FILE"
echo "$RUN_COMMAND"
eval $RUN_COMMAND