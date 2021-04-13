#!/usr/bin/env bash
set -e

if [ -z "$GITLAB_PRIVATE_TOKEN" ]; then
  echo "GITLAB_PRIVATE_TOKEN not set"
  echo "Please set the GitLab Private Token as GITLAB_PRIVATE_TOKEN"
  exit 1
fi

# Extract the host where the server is running, and add the URL to the APIs
[[ $CI_PROJECT_URL =~ ^https?://[^/]+ ]] && HOST="${BASH_REMATCH[0]}/api/v4/projects/"

BODY="{
    \"id\": ${CI_PROJECT_ID},
    \"source_branch\": \"master\",
    \"target_branch\": \"develop\",
    \"remove_source_branch\": \"false\",
    \"title\": \"Finalize Deploy\",
    \"assignee_id\":\"${GITLAB_USER_ID}\"
}";


# Require a list of all the merge request and take a look if there is already
# one with the same source branch
LISTMR=$(curl --silent "${HOST}${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${GITLAB_PRIVATE_TOKEN}");
COUNTBRANCHES=$(echo "${LISTMR}" | grep -o "\"source_branch\":\"${CI_COMMIT_REF_NAME}\"" | wc -l);

# No MR found, let's create a new one
if [ "${COUNTBRANCHES}" -eq "0" ]; then
    curl -X POST "${HOST}${CI_PROJECT_ID}/merge_requests" \
        --header "PRIVATE-TOKEN:${GITLAB_PRIVATE_TOKEN}" \
        --header "Content-Type: application/json" \
        --data "${BODY}";

    echo "Deploy success. To finalize, accept the merge request from master to develop."
    exit;
fi

echo "Final merge request was not created.";

