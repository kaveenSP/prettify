FROM python:3.9-slim-buster

WORKDIR /app

COPY backend/requirements.txt .

RUN pip install -r requirements.txt

COPY backend .

EXPOSE 8080

ENTRYPOINT [ "python" ]

CMD ["app.py"]