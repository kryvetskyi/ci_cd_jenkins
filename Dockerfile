FROM python:3
RUN pip3 install --upgrade pip
WORKDIR /app
COPY requirements.txt .
RUN pip3 install -r requirements.txt
COPY . .
CMD ["gunicorn", "-b", "0.0.0.0:8000", "look.app:get_app()"]