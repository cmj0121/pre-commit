FROM python:3.10.4-alpine3.15

ARG PRE_COMMIT_VER=2.19.0

RUN pip install --no-cache-dir pre-commit==$PRE_COMMIT_VER
