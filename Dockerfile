# The UI is not compatible with node >= 18.16
# See: https://github.com/firebase/firebase-tools-ui/issues/933
FROM nikolaik/python-nodejs:python3.11-nodejs18-alpine

RUN apk add openjdk17-jre-headless

# workaround java sigsev
RUN apk --no-cache add gcompat
ENV LD_PRELOAD=/lib/libgcompat.so.0

# 
WORKDIR /build
ADD package.json package-lock.json /build/
RUN npm install
ENV PATH=/build/node_modules/.bin:$PATH
RUN firebase --debug setup:emulators:firestore
RUN firebase --debug setup:emulators:ui
RUN firebase --debug setup:emulators:pubsub

EXPOSE 4000 440 4500 5001 8080 9299

# start your container with your custom firebase.json, workspace, command

WORKDIR /demo

ADD firebase.json /demo/
ADD start.sh /demo/
CMD ["/demo/start.sh"]
