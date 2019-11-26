FROM golang:latest AS build
COPY . /go/build
WORKDIR /go/build
RUN GIT_COMMIT=$(git rev-list -1 HEAD) && go build -o booktaxi -ldflags "-X main.CommitSHA=$GIT_COMMIT" ./pkg/cmd/booktaxi

FROM registry.access.redhat.com/ubi8/ubi-minimal
WORKDIR /root/
COPY --from=build /go/build/booktaxi .
COPY --from=build /go/build/pkg/web/index.html /usr/share/booktaxi/
EXPOSE 8080
CMD ["./booktaxi"]
