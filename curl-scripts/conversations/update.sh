# Ex: TOKEN=tokengoeshere ID=idgoeshere TEXT=textgoeshere sh curl-scripts/examples/update.sh

curl "http://localhost:4741/conversations/${ID}" \
  --include \
  --request PATCH \
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
