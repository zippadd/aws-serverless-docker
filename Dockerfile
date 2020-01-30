FROM amazonlinux:2

RUN yum list yum && \
  yum install -y --installroot=/installroot --releasever=2 shadow-utils tar gzip zip && \
  yum install -y --installroot=/installroot python3 && \
  yum install -y python3-devel gcc && \
  pip3 --no-cache-dir install --upgrade pip setuptools && \ 
  pip3 --no-cache-dir install --root /installroot awscli==1.17.9 && \
  pip3 --no-cache-dir install --root /installroot aws-sam-cli==0.40.0 && \
  yum remove -y python3-devel gcc && \
  yum autoremove --installroot=/installroot -y && \
  yum clean -y all && \
  rm -rf /var/cache/yum

FROM lambci/lambda:nodejs12.x

USER root
ENV PATH=$PATH:/sbin
COPY --from=0 /installroot/etc /etc/
COPY --from=0 /installroot/sbin /sbin/
COPY --from=0 /installroot/usr /usr/

RUN aws configure set default.region us-east-1 && aws configure set default.s3.max_concurrent_requests 50 && \
  chown -R root /tmp && chgrp -R root /tmp && chmod -R 1777 /tmp && \
  npm install npm@latest -g && \
  npm cache clean --force && \
  echo AWS CLI: `aws --version` && \
  echo SAM CLI: `sam --version` && \
  echo Node: `node --version` && \
  echo NPM: `npm --version` && \
  echo Useradd: `useradd --help` && \
  echo Usermod: `usermod --help` && \
  echo Groupadd: `groupadd --help`

ENTRYPOINT []
CMD ["/var/lang/bin/node", "-e", "setInterval(function(){}, 24 * 60 * 60 * 1000);"]
