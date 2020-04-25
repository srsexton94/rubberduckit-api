#!/bin/bash

curl "http://localhost:4741/conversations" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "conversation": {
      "title": "'"${TITLE}"'",
      "body": "'"${BODY}"'",
      "notes": "'"${NOTES}"'",
      "solved": "'"${SOLVED}"'",
      "user_id": "'"${USER}"'"
    }
  }'

echo
