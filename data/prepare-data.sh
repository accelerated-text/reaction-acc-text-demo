#!/bin/sh

curl -XPOST http://localhost:3001/_graphql -H 'Content-Type: application/json' -d @authorship_plan.json
