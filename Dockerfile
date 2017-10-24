FROM ibmcom/ibmnode

ENV NODE_ENV production
ENV PORT 3000
ENV USE_ZIPKIN true

WORKDIR "/app"

# Install app dependencies
COPY package.json /app/
RUN cd /app;
RUN npm install;

# Bundle app source
COPY . /app

EXPOSE 3000
CMD ["npm", "start"]
