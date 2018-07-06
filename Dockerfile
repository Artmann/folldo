FROM crystallang/crystal as build

WORKDIR /app

COPY shard.yml shard.lock /app/

RUN shards

COPY . .

RUN crystal build --release --static src/folldo.cr

FROM alpine:latest

WORKDIR /app

EXPOSE 15200

COPY --from=build /app/folldo .

CMD /app/folldo