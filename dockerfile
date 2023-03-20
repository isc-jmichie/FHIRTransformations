FROM containers.intersystems.com/intersystems/irishealth:2022.1.1.374.0

ARG IRIS_PASSWORD

USER irisowner

WORKDIR /opt/irisapp
RUN chown irisowner:irisowner /opt/irisapp

COPY . .

ENTRYPOINT ["/iris-main"]