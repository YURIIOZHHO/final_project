FROM node:14 as build

WORKDIR /app

COPY package.json yarn.lock ./

RUN npm install -g @angular/cli@7 \
    && yarn install

COPY . .

RUN ng build --prod


FROM nginx:alpine

COPY --from=build /app/dist/eSchool /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80