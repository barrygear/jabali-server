FROM golang:1.19 AS build
WORKDIR /go/src
COPY go ./go
COPY main.go .
COPY go.sum .
COPY go.mod .

ENV CGO_ENABLED=0

RUN go build -o jabaliSDK .

FROM scratch AS runtime
ENV GIN_MODE=release
COPY --from=build /go/src/jabaliSDK ./
EXPOSE 8080/tcp
ENTRYPOINT ["./jabaliSDK"]
