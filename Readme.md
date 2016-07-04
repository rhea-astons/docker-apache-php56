# docker-debian-moodle
A Dockerfile that installs and runs Apache, PHP 5.6 and SSH on Debian 8.5.

## Installation
```
docker build -t apache-php56 .
```

## Usage
```
docker run -d --name foobar -e HOSTNAME=foobar.lo -p 7331:7331 -p 8080:80 -v /FOO/BAR:/var/www rsnts/apache-php56
```