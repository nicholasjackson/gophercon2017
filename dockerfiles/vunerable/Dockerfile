FROM node

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

RUN curl -fsSL https://apt.dockerproject.org/gpg | apt-key add -; \
    add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       debian-$(lsb_release -cs) \
       main"; \
    apt-get update; \
    apt-get -y install docker-engine

COPY ./app /app

WORKDIR /app

RUN cd /app

RUN npm install; \
    ls -las ./node_modules


CMD ["npm","start"]
