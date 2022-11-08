# TRAEFIK RASPBERRY FRESH INSTALL

### Configuration Examples
* traefik config
```toml
[api]
  dashboard = true

[entryPoints]
  [entryPoints.web]
    address = ":80"
    [entryPoints.web.http]
      [entryPoints.web.http.redirections]
        [entryPoints.web.http.redirections.entryPoint]
          to = "websecure"
          scheme = "https"
          permanent = true

  [entryPoints.websecure]
    address = ":443"
      [entryPoints.websecure.http.tls]
        certResolver = "default"

[providers]
  [providers.docker]
    watch = true
    exposedByDefault = false
    network = "web"

[certificatesResolvers]
  [certificatesResolvers.default]
    [certificatesResolvers.default.acme]
      email = "your@email.com"
      storage = "acme.json"
      caServer = "https://acme-v01.api.letsencrypt.org/directory"
    [certificatesResolvers.default.acme.tlsChallenge]
```
##########################################


## Before run project
```
cp ./.env.exemple ./.env
cp ./traefik/conf/traefik.exemple ./traefik/conf/traefik.toml

sudo apt-get -y install make
make -e user=toto basic-auth-pwd
```

## Before run project
Edit your `.env` with your own information
Edit your `./traefik/conf/traefik.toml` with your own information


## Run traefik
```
make all
```

### Help
```
make help
```