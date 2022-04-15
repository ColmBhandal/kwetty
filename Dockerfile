FROM node:current-alpine as builder
RUN apk add -U build-base python3 git
RUN git clone https://github.com/butlerx/wetty.git
RUN mkdir -p /usr/src/app/json-package-dir && cp wetty/package.json /usr/src/app/json-package-dir
RUN cp -a /wetty/. /usr/src/app
WORKDIR /usr/src/app
RUN yarn && \
    yarn build && \
    yarn install --production --ignore-scripts --prefer-offline

FROM runtimeverificationinc/kframework-k:ubuntu-focal-5.3.14
LABEL maintainer="notmaintained@notthe.cloud"
WORKDIR /usr/src/app
EXPOSE 3000
COPY --from=builder /usr/src/app/json-package-dir /usr/src/app
COPY --from=builder /usr/src/app/build /usr/src/app/build
COPY --from=builder /usr/src/app/node_modules /usr/src/app/node_modules
RUN apt-get -y install coreutils openssh-client sshpass && \
    mkdir ~/.ssh

ENTRYPOINT ["yarn", "start"]