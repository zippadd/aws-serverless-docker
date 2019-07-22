FROM zippadd/lambda:nodejs10.x
RUN yum install -y shadow-utils util-linux python-pip icu && \
  yum install -y gcc python-devel && \
  pip --no-cache-dir install --upgrade pip setuptools && \
  pip --no-cache-dir install awscli && aws configure set default.region us-east-1 && aws configure set default.s3.max_concurrent_requests 50 && \
  pip --no-cache-dir install aws-sam-cli && \
  npm install npm@latest -g && \
  yum remove -y gcc python-devel python-pip && \
  yum autoremove -y && \
  yum clean -y all && \
  rm -rf /var/cache/yum && \
  npm cache clean --force && \
  echo AWS CLI: `aws --version` && \
  echo SAM CLI: `sam --version` && \
  echo Node: `node --version` && \
  echo NPM: `npm --version`
USER root
ENV PATH=$PATH:/sbin
ENTRYPOINT []
CMD ["/var/lang/bin/node", "-e", "setInterval(function(){}, 24 * 60 * 60 * 1000);"]
