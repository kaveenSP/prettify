FROM ubuntu

RUN apt-get update -y python-pip python-dev

COPY ./backend/requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

COPY . /app

ENTRYPOINT [ "python" ]

CMD ["app.py"]