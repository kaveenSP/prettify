FROM python:3.9-slim-buster

WORKDIR /app

COPY prettify/backend/requirements.txt .

RUN pip install -r requirements.txt

COPY prettify/backend .

EXPOSE 8000

ENTRYPOINT [ "python" ]

CMD ["app.py"]