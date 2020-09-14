ARG PYTHON_IMAGE=3.8-slim

FROM python:$PYTHON_IMAGE

WORKDIR /usr/local/src/python-checker

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

ENTRYPOINT ["/usr/local/src/python-checker/entrypoint.sh"]

