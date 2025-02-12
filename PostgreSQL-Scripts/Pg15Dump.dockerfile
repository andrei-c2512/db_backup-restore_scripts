FROM uselagoon/postgres-15 AS pg15
USER postgres

COPY dumpEntrypoint.sh /usr/local/bin/

#chmod este un unix command care iti permite sa schimbi permisiunile unui fisier
# +x il face executabil
#RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/dumpEntrypoint.sh"]
CMD ["bash"]
#RUN psql -h localhost -p 5432 -U postgres
#RUN CREATE DATABASE oldDb;
#RUN CREATE TABLE test ( val INT PRIMARY KEY , name varchar(50));


#WORKDIR /pg17

#cand mi am pus postgres pe windows de asa multe ori nu o trebuit niciodata sa initializez data directory-ul wtf
#RUN mkdir /var/lib/postgres/data/pg17 && \
#    initdb -D /var/lib/postgresql/data/pg17

#FROM uselagoon/postgres-15 AS pg15
#COPY . /pg15
#USER postgres
#WORKDIR /pg15

#RUN mkdir /var/lib/postgres/data/pg15 && \
#    initdb -D /var/lib/postgresql/data/pg15
