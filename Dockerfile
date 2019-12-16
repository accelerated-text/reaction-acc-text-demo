FROM alpine:3.7

ARG WAIT_FOR
ENV WAIT_FOR_URL=${WAIT_FOR}

RUN apk add curl

COPY data/authorship_plan.json authorship_plan.json
COPY data/dress_plan.json dress_plan.json
COPY data/prepare-data.sh prepare-data.sh
COPY data/wait_for.sh wait_for.sh

RUN chmod +x wait_for.sh

ENTRYPOINT ["/bin/sh", "wait_for.sh"]
