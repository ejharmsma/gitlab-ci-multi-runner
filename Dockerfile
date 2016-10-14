FROM docker:latest

MAINTAINER Edwin Harmsma <edwin.harmsma@tno.nl>

# Bash and Git are required for CI runner clone and run
RUN apk --no-cache add bash git && \
    wget -O gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64 && \
    chmod +x gitlab-ci-multi-runner && \
    mkdir /gitlab-config

# Volume to store the config file
VOLUME ["/gitlab-config"]

ENV CONFIG_FILE=/gitlab-config/config.toml

# TODO: ENABLE ENTRYPOINT AGAIN
#ENTRYPOINT ["./gitlab-ci-multi-runner"]

CMD ["./gitlab-ci-multi-runner", "run"]

