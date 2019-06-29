FROM amazonlinux:2 AS pkgMgr
RUN yum install -y shadow-utils && \
  yum install -y util-linux && \
  yum clean all
RUN ls /sbin && ls /usr/bin

FROM lambci/lambda:nodejs10.x AS source

FROM lambci/lambda:nodejs10.x
COPY --from=pkgMgr / /
COPY --from=source /etc/passwd /etc
ENV PATH=$PATH:/sbin
ENTRYPOINT []
CMD ["/var/lang/bin/node", "-e", "setInterval(function(){}, 24 * 60 * 60 * 1000);"]