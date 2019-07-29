FROM zippadd/lambda:nodejs10.x
RUN yum install -y shadow-utils util-linux python-pip icu zip perl && \
  yum install -y gcc python-devel bzip2 make && \
  pip --no-cache-dir install --upgrade pip setuptools && \
  pip --no-cache-dir install awscli && aws configure set default.region us-east-1 && aws configure set default.s3.max_concurrent_requests 50 && \
  pip --no-cache-dir install aws-sam-cli && \
  npm install npm@latest -g && \
  curl http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 --output parallel.tar.bz2 && \
  mkdir parallel && \
  tar -xvjf parallel.tar.bz2 -C parallel --strip 1 && \
  cd parallel && \
  ./configure && \
  make install && \
  cd .. && \
  rm -Rf parallel* && \
  mkdir ~/.parallel && \
  touch ~/.parallel/will-cite && \
  yum remove -y gcc python-devel python-pip bzip2 make && \
  yum autoremove -y && \
  yum clean -y all && \
  rm -rf /var/cache/yum && \
  npm cache clean --force && \
  echo AWS CLI: `aws --version` && \
  echo SAM CLI: `sam --version` && \
  echo Node: `node --version` && \
  echo NPM: `npm --version` && \
  echo Parallel: `parallel --version`
USER root
ENV PATH=$PATH:/sbin
ENTRYPOINT []
CMD ["/var/lang/bin/node", "-e", "setInterval(function(){}, 24 * 60 * 60 * 1000);"]
