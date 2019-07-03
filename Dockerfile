FROM zippadd/lambda:nodejs10.x
RUN yum install -y shadow-utils && \
  yum install -y util-linux && \
  yum clean all && \
  rm -rf /var/cache/yum
USER root
ENV PATH=$PATH:/sbin
ENTRYPOINT []
CMD ["/var/lang/bin/node", "-e", "setInterval(function(){}, 24 * 60 * 60 * 1000);"]
