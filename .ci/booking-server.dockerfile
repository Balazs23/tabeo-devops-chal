FROM golang:1.16.15 as build

# based on mod file
WORKDIR /usr/src/spacetrouble

# copy content for build
COPY . .

RUN go mod download \
    && go build -o /booking-server ./cmd/booking-server/main.go

FROM alpine as app
COPY --from=build /booking-server .
# go compiled with glibc alpine doesn’t have the right libs to run it, symlink for it
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
CMD ["./booking-server"]
