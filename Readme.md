# PROXY RASPBERRY FRESH INSTALL

## Docker | ZSH | Make install

### Update

```sh
sudo apt update
sudo apt upgrade
```

### Installation ZSH && Oh My ZSH (option)
```sh
sudo apt install zsh
zsh --version
chsh -s $(which zsh)
sudo apt install git
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

### Installation make
```
sudo apt-get -y install make -y
```

### Installation Docker
```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

#### replace pi with your user
```sh
sudo usermod -aG docker pi
sudo shutdown -r now
```

#### test docker
```sh
docker run hello-world
```

## TRAEFIK

## Install requirements

### Auto Install
```
bash ./scripts/init.sh
```

### Manual Install
```
sudo apt-get install apache2-utils -y
touch ./traefik/conf/acme.json && chmod 600 ./traefik/conf/acme.json
cp ./.env.exemple ./.env
cp ./traefik/conf/traefik.exemple ./traefik/conf/traefik.yml

Edit your `.env` with your own information
Edit your `./traefik/conf/traefik.yml` with your own information
```

## Init basic auth
```
make -e user=your_user basic-auth-pwd
```
> replace value of TRAEFIK_BASIC_AUTH key in your .env

## Run traefik
```
make all
```

### Help
```
make help
```
