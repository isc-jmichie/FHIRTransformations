FROM intersystemsdc/irishealth-community:latest

ARG IRIS_PASSWORD

USER irisowner

WORKDIR /opt/irisapp
RUN chown irisowner:irisowner /opt/irisapp

COPY . .

ENTRYPOINT ["/iris-main"]