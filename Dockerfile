FROM amazoncorretto:17.0.2-al2

# Variaveis de ambiente
ENV WILDFLY_VERSION 25.0.1.Final
ENV WILDFLY_DIR wildfly-$WILDFLY_VERSION

ADD files/$WILDFLY_DIR.tar.gz /
COPY files/datasource-ds.xml $WILDFLY_DIR/standalone/deployments

RUN mkdir -p $WILDFLY_DIR/modules/org/postgresql/main
COPY files/postgresql-42.2.5.jar        $WILDFLY_DIR/modules/org/postgresql/main
COPY files/postgresql-42.2.5.module.xml $WILDFLY_DIR/modules/org/postgresql/main/module.xml

RUN mkdir -p $WILDFLY_DIR/modules/com/p6spy/main
COPY files/p6spy-3.9.1.jar              $WILDFLY_DIR/modules/com/p6spy/main
COPY files/p6spy-3.9.1.module.xml       $WILDFLY_DIR/modules/com/p6spy/main/module.xml

RUN ./$WILDFLY_DIR/bin/add-user.sh admin adminadmin

#RUN chown -R root: $WILDFLY_DIR
#RUN ls -l
RUN mv $WILDFLY_DIR/ /server
CMD ["./server/bin/standalone.sh", "-c", "standalone-microprofile.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "--debug", "*:8787"]