FROM elixir:1.10.4 AS builder
WORKDIR /app
COPY . .

RUN mix local.hex --force && \
	mix archive.install hex phx_new 1.5.4 --force && \
	mix local.rebar --force

RUN mix deps.get

RUN REPLACE_OS_VARS=true mix release

FROM ubuntu:20.04

WORKDIR /app

RUN apt update && apt install -y openssl inotify-tools && rm -rf /var/cache/apt

COPY --from=builder /app/_build/dev/rel/mini_program_proxy_elixir .

CMD ["bin/mini_program_proxy_elixir", "start"]