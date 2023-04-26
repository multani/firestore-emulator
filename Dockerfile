# The UI is not compatible with node >= 18.16
# See: https://github.com/firebase/firebase-tools-ui/issues/933
FROM node:18.15-alpine

RUN apk add openjdk17-jre-headless

WORKDIR /app
ADD package.json package-lock.json /app/
RUN npm install
ENV PATH=/app/node_modules/.bin:$PATH
RUN firebase --debug setup:emulators:firestore
RUN firebase --debug setup:emulators:ui

EXPOSE 4000 4500 8080

ADD firebase.json /app/
CMD ["/app/start.sh"]
ADD start.sh /app/
