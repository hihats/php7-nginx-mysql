# Setup Dockerized development environment
- Docker環境をローカルマシンに作成
- composerでFWなどのパッケージを導入して使用する想定

## Installation
[Docker Toolbox](https://www.docker.com/products/docker-toolbox)

dockerコマンド、docker-machineコマンド、docker-composeコマンド全部入り
```bash
$ brew cask install dockertoolbox
```
でも可

## Initial Setting
### Launch Docker Host OS
docker-machineコマンドを使用
```bash
$ docker-machine create --driver virtualbox myservice
$ docker-machine start myservice
```
### 起動を確認
```bash
$ docker-machine ls
```
### 接続
```bash
$ docker-machine env myservice
```
`# Run this command to configure your shell:`と出力されるので従う

    別のDocker machineを使う場合はその都度設定する必要あり

## コンテナレジストリにログイン認証を通す
e.g. [Dockerhub](https://hub.docker.com/)を使った例
     アカウントを取得しておく
```bash
$ docker login
```
`Login Succeeded`5656

これでSetup準備完了


### Docker Container Setup
docker-composeコマンドを使い、複数コンテナを起動する
(設定は`docker-compose.yml`)
```
$ docker-compose build
Successfully built.

$ docker-compose up -d
```
composer.jsonに書かれているパッケージがインストールされる（Laravel in this case）
コンテナの起動確認
```
$ docker ps
```

## Setting environment valuables
コンテナ間の接続の設定
```bash
$ docker exec web env
```

出力されたMYSQL***の値を`.env`に設定
```
DB_HOST       = 172.17.**.**
DB_PORT       = 3306
DB_DATABASE   = MYSQL_DATABASE
DB_USERNAME   = myservice
DB_PASSWORD   = secret
```

$DOCKER_HOSTの値を、ローカルの`/etc/host`に追記  
```
192.168.***.**  dev.myservice.jp
```

`dev.myservice.jp` ブラウザアクセスしてLaravelの確認

### data import
データ専用のコンテナを作成する迄は、一旦S3からコピーする
```bash
$ aws s3 cp s3://mybucket/db_dump.sql containers/db/dump.latest.sql
$ docker exec db /bin/bash /var/tmp/mysql/entrypoint.sh
```
