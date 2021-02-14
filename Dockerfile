# BUILD PHASE
# Section ton install all dependencies (builder)
FROM node:alpine as builder

#Specify the working DIRECTORY
WORKDIR '/app'
#Install some dependencies
COPY package*.json ./
#Install npm
RUN npm install
#Copy the remaining files
COPY . .
#Run npm with production parameter
RUN npm run build




#RUN PHASE
#Section for the Nginx server
FROM nginx
#Exposer ce port en production pour notre serveur
EXPOSE 80
# copy from "builder"
#Get files from container wokdir/build to ngnx working dir /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
