FROM "alpine"
COPY build/* /usr/bin
ENTRYPOINT ["wait-for-mysql"]
