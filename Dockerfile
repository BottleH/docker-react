# 여기 FROM부터 다음 FROM 전까지는 모두 builder stage라는 것을 명시
FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

CMD [ "npm", "run", "build" ]
# 여기까지 build stage build 폴더로 들어감

# nginx를 위한 베이스이미지`
FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
# 여기는 run stage임. 빌드파일들을 생성하는 것, build 폴더로 들어감