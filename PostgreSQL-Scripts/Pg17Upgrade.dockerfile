FROM uselagoon/postgres

USER postgres

COPY restoreEntrypoint.sh /usr/local/bin
COPY olddb.sql /tmp/newdb.sql

ENTRYPOINT ["/usr/local/bin/restoreEntrypoint.sh"]

CMD ["bash"]
