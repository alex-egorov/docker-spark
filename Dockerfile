FROM alex202/hadoop

ENV SPARK_VER 2.2.1
ENV SPARK_HOME /opt/spark
ENV SPARK_CONF_DIR $SPARK_HOME/conf

# if numpy is installed on a driver it needs to be installed on all
# workers, so install it everywhere
RUN apt-get update && \
    apt-get install -y python-numpy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install spark
RUN cd /opt \
    && echo Downloading http://www.eu.apache.org/dist/spark/spark-${SPARK_VER}/spark-${SPARK_VER}-bin-hadoop2.7.tgz ... \
    && curl http://www.eu.apache.org/dist/spark/spark-${SPARK_VER}/spark-${SPARK_VER}-bin-hadoop2.7.tgz | tar -zx \
    && ln -s spark-${SPARK_VER}-bin-hadoop2.7 spark


#COPY log4j.properties ${SPARK_CONF_DIR}/log4j.properties
#COPY spark-defaults.conf ${SPARK_CONF_DIR}/spark-defaults.conf
COPY conf/* ${SPARK_CONF_DIR}/
ENV PATH $PATH:${SPARK_HOME}/bin

COPY start-spark.sh /etc/start-spark.sh
RUN chown root:root /etc/start-spark.sh \
  && chmod +x /etc/start-spark.sh

ENV WORKER localhost

ENTRYPOINT ["/etc/start-spark.sh", "-d"]



# Spark ports
EXPOSE 4040 8080