FROM python:3.8

#WORKDIR /opt/django-test-app/
COPY . /opt/
WORKDIR /opt/ 
RUN chmod +x manage.py
RUN apt-get update
RUN apt-get install -y nginx
RUN /etc/init.d/nginx start
RUN ln -s ./demo_nginx.conf /etc/nginx/sites-enabled/
#RUN ./etc/init.d/service nginx start
#RUN /etc/init.d/nginx restart
EXPOSE 8000
RUN pip install -r requirements.txt
#CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
#CMD ["uwsgi", "--http", ":8000", "--rm", "--module", "demo.wsgi"]
#CMD ["uwsgi", "--socket", "demo.sock", "--wsgi-file", "test.py"]
CMD ["uwsgi", "--socket", "demo.sock", "--module", "demo.wsgi", "--chmod-socket=664"]
