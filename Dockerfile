# BUILD PHASE
# Section ton install all dependencies (builder)
FROM node:alpine as builder

#Specify the working DIRECTORY
#WORKDIR '/app'
WORKDIR /app
#Install some dependencies
#COPY package.json .
COPY package.json package-lock.json ./
#Install npm
#RUN npm install
RUN npm install
#Copy the remaining files
COPY . ./
#Run npm with production parameter
RUN npm run build

#RUN PHASE
#Section for the Nginx server
FROM nginx

#COPY nginx.conf /etc/nginx/nginx.conf

#RUN rm -rf /usr/share/nginx/html/*
#COPY --from=builder /builddir/build /usr/share/nginx/html
#RUN rm /etc/nginx/conf.d/default.conf
#COPY nginx/nginx.conf /etc/nginx/conf.d
#Exposer ce port en production pour notre serveur

#CMD ["nginx", "-g", "daemon off;"]
# copy from "builder"
#Copy config file
#COPY --from=builder /builddir/nginx.conf /etc/nginx/conf.d/default.conf
#Get files from container wokdir/build to ngnx working dir /usr/share/nginx/html
#COPY default.conf /etc/nginx/conf.d/default.conf
#COPY --from=builder /app/build /usr/share/nginx/html

#EXPOSE 3000 80
#ENTRYPOINT ["nginx", "-g", "daemon off;"]
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]