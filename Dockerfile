FROM crystallang/crystal as build

WORKDIR /app

COPY . .

RUN shards

RUN crystal build --release --static src/folldo.cr

FROM alpine:latest

WORKDIR /app

EXPOSE 15200

COPY --from=build /app/folldo .

CMD /app/folldo