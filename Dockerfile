# BUILD PHASE
# Section ton install all dependencies (builder)
FROM node:alpine as builder

#Specify the working DIRECTORY
#WORKDIR '/app'
WORKDIR /app
#Install some dependencies
#COPY package.json .
COPY package.json  .
#Install npm
#RUN npm install
RUN npm install
#Copy the remaining files
COPY . .
#Run npm with production parameter
#RUN npm run build
RUN ["npm","run", "build"]

#RUN PHASE
#Section for the Nginx server
FROM nginx

#EXPOSE PORT 80
EXPOSE 80
#COPY THE Build folder into nginx html file
COPY --from=builder /app/build /usr/share/nginx/html
#COPY default.conf /etc/nginx/conf.d/default.conf

