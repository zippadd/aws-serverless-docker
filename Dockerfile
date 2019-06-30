FROM amazonlinux:2 AS pkgMgr
RUN yum install -y shadow-utils && \
  yum install -y util-linux && \
  yum clean all && \
  rm -rf /var/cache/yum
RUN ls /
FROM lambci/lambda:nodejs10.x AS source
FROM lambci/lambda:nodejs10.x
USER root
#COPY --from=pkgMgr / /
COPY --from=pkgMgr etc /etc
COPY --from=pkgMgr usr/bin /usr/bin
COPY --from=pkgMgr usr/sbin /usr/sbin
COPY --from=pkgMgr usr/lib /usr/lib
COPY --from=pkgMgr usr/lib64 /usr/lib64
COPY --from=source /etc/passwd /etc
ENV PATH=$PATH:/sbin
ENTRYPOINT []
CMD ["/var/lang/bin/node", "-e", "setInterval(function(){}, 24 * 60 * 60 * 1000);"]