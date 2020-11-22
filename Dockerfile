FROM python:3.8.6-alpine3.12 as build
# The python:3.7 image is HUGE but already comes with all the essentials
# for compiling (most) python modules with native dependencies
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN pip install pipenv

WORKDIR /build
COPY Pipfile Pipfile.lock /build/
RUN sh -c 'PIPENV_VENV_IN_PROJECT=1 pipenv install'

FROM python:3.8.6-alpine3.12 as application
# But python:3.7-slim is ~143MB, so you can expect your final image
# size to be 143 + dependencies + application.
# A scrapy+sqlalchemy+psycopg2 project ends up at ~225MB
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

WORKDIR /app
COPY --from=build /build /app/
COPY /app/ /app/

# Change this to call your app
CMD .venv/bin/python main.py
