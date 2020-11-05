# Setting up and running the Mini Program Elixir Proxy

This guide will explain how to set up, run and use the proxy. Any tools needed will be linked to and left as an exercise to the reader to install. The readme will also only focus on Ubuntu and other platforms will not be discussed.

## 1. Install Elixir with Erlang

1.1 See the [Installation Guide](https://elixir-lang.org/install.html) on the official elixir page.

## 2. Setting up the server

### 2.1 Installing Dependencies
To install dependencies run the following command in the project root.
```bash
mix deps.get
```
When asked to install rebar3 say yes.

### 2.2 Starting up the server
To start the server run the following command:
```bash
PROXY_HOST=https://hostname mix phx.server
```
The `PROXY_HOST` environment variable refers to the location where any requests will be proxied to. For example, if the server is started with `PROXY_HOST=https://www.google.com mix phx.server` all requests to the proxy will be forwarded to `https://www.google.com`. The server starts up on port `6000`.

## 3. Using the proxy
The proxy is intended to be used for proxy-ing some `GET` calls to `DELETE` calls and some `POST` calls to `PUT` calls since the mini program system does not currently support the `DELETE` and `PUT` HTTP verbs. All headers sent will also be forwarded. All headers returned by the `PROXY_HOST` will also be returned to the client.

### 3.1 Making a PUT call
Simply prepend the put parameter in the api query for a `POST` request. For example, say you want to do the call `PUT /profile/:id` you would call the proxy with `POST /put/profile/:id`. The proxy will then do a `PUT` call to the `PROXY_HOST` on your behalf. 

### 3.2 Making a DELETE call
Simply prepend the delete parameter in the api query for a `GET` request. For example, say you want to do the call `DELETE /posts/:id` you would call the proxy with `GET /delete/posts/:id`. The proxy will then do a `DELETE` call to the `PROXY_HOST` on your behalf. 

All calls not prepended by either of these verbs will be forwarded without as-is to the `PROXY_HOST`.

## 4. Compiling for server deploy.

For deploying on a server it will be optimal to have a compiled binary that can just be run on the server. To create a self-contained release for running on a server run `mix release` this will compile the project with all needed binaries and libraries to a folder.

The folder can then be accessed at `_build/dev/rel/mini_program_proxy_elixir`.

The application can be run with `bin/mini_program_proxy_elixir start`.

## 5. Building into Docker container
A Dockerfile has already been included. It can be built with `docker build -t tag:version .`.

Afterwords it can be run like this:
```bash
docker run -it -p 6000:6000 -e PROXY_HOST=https://hostname tag:version
```