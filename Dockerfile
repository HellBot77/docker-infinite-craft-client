FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/HellLord77/infinite-craft-client.git && \
    cd infinite-craft-client && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM node:alpine AS build

WORKDIR /infinite-craft-client
COPY --from=base /git/infinite-craft-client .
RUN npm install && \
    npm run build

FROM lipanski/docker-static-website

COPY --from=build /infinite-craft-client/dist/infinite-craft-client/browser .
