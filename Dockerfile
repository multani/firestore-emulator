FROM node:lts-alpine

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
