FROM node:14.21.3-alpine
WORKDIR /app
copy . .
RUN npm install
EXPOSE 3000
CMD [ "npm", "start" ]
