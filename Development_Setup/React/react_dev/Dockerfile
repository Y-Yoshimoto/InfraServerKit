# FROM node:latest
FROM node:alpine
LABEL maintaner='y-yoshimoto'

RUN npx create-react-app my-app && \
    rm -rf /my-app/src/*
# Remove Sample
WORKDIR /my-app
VOLUME /my-app

# Copy 
# COPY react_dev/src/* /my-app/src/

EXPOSE 3000 

ENTRYPOINT ["tail", "-f", "/dev/null"]
#ENTRYPOINT ["npm", "start"]
