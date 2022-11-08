# TRAEFIK RASPBERRY FRESH INSTALL

### Installation pre-requis

* [Install zsh and oh my zsh (Optional)](https://les-enovateurs.com/oh-my-zsh-installation-rapide-linux)

* [Install docker](https://www.framboise314.fr/installer-docker-sur-raspberry-pi/)

* Reboot your raspi
```
sudo shutdown -r now
```

##########################################

### Configuration Examples
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

## Install requirements
```
sudo apt-get -y install make -y
sudo apt-get install apache2-utils -y
```

## Before run project
```
cp ./.env.exemple ./.env
cp ./traefik/conf/traefik.exemple ./traefik/conf/traefik.toml
```

## Init basic auth
```
make -e user=john basic-auth-pwd
```
> replace value of TRAEFIK_BASIC_AUTH key in your .env

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