FROM golang:cross

WORKDIR /app

ARG app_env
ENV APP_ENV $app_env

# The golang Docker sets the $GOPATH to be /go
# https://github.com/docker-library/golang/blob/c1baf037d71331eb0b8d4c70cff4c29cf124c5e0/1.4/Dockerfile

COPY . .

RUN go build -o main . 

EXPOSE 8080

CMD if [ ${APP_ENV} = production ]; \
	then \
	app/main; \
	else \
	go get github.com/pilu/fresh && \
	fresh; \
	fi
