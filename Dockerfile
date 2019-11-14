FROM java:8
VOLUME /tmp
ADD dyl-admin.jar app.jar
EXPOSE 8800
ENTRYPOINT ["java","-jar","app.jar"]