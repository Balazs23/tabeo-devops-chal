FROM golang:1.19 as base

WORKDIR $GOPATH/src/migrate/

RUN go install github.com/jackc/tern@v1.13.0
RUN cp $GOPATH/bin/tern /tern

FROM alpine as app
# go compiled with glibc alpine doesn’t have the right libs to run it, symlink for it
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY --from=base /tern .
COPY /migrations /migrations

CMD ["./tern", "migrate", "-m", "/migrations"]