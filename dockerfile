FROM alpine:3.16.2

ARG TIME_ZONE

ENV TIME_ZONE=${TIME_ZONE}

RUN apk --update --no-cache add bash dcron 

RUN apk --update --no-cache add tzdata \
    && cp /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime \ 
    && echo ${TIME_ZONE} > /etc/timezone

WORKDIR /cleaner

COPY ./crontab ./crontab
COPY ./clean.sh ./clean.sh

COPY ./run.sh ./run.sh

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/cleaner/run.sh" ]