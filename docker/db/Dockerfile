FROM mysql:5
LABEL description="MySQL with a new user already set up"
LABEL maintainer="Mathias Kegelmann"

COPY initdb/* /docker-entrypoint-initdb.d
