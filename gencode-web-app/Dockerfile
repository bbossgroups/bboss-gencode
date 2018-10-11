FROM frolvlad/alpine-oraclejdk8
ADD --chown=root:root gencode /opt/gencode
RUN chmod -R +x /opt/gencode
CMD ["/opt/gencode/startup.sh"]
