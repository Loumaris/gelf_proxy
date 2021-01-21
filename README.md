
# gelf proxy service

Just a simple sinatra app that will forward posted json to a gelf input of graylog with basic auth protection.
You can run this as container or standalone - or in any cluster.

## Environment
* Ruby 2.6.6
* Sinatra 2.1.0

## usage

### configuration

The most important things can be configured via ENV or yml file (`config/proxy.yml`):

| ENV             | description                                   | default    |
|-----------------|-----------------------------------------------|------------|
| APP_NAME        | will set the app name to the graylog facility | gelf proxy |
| LOG_SERVER      | logging server url or ip                      |            |
| LOG_SERVER_PORT | gelf input port                               | 12201      |
| LOGGER_USERNAME | Username for http auth                        | gelf       |
| LOGGER_PASSWORD | Password for http auth                        | fleg       |
| SUBPATH_URI     | subpath on your env                           | /          |

Please notice that env-configuration will overwrite yml configuration.
The `SUBPATH_URI` can only be set via ENV, because it is needed before the app has been started.

### post json example

e.g.

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"username":"xyz","password":"xyz"}' \
  http://gelf:fleg@localhost:4567/log
```

this will post the json to sinatra and redirect it to graylog.

## Development

Sinatras autoreload feature is active, it will reload all `*.rb` files in `/lib` (feel free to watch other directories too).

### without docker

1. Bundle gems locally:

```
$ bundle install
```

2. Run app from root. Will load app on http://localhost:4567 by default.

```
$ bundle exec rackup config.ru -p 4567

[2020-09-15 08:22:52] INFO  WEBrick 1.4.2
[2020-09-15 08:22:52] INFO  ruby 2.6.6 (2020-03-31) [x86_64-linux]
[2020-09-15 08:22:52] INFO  WEBrick::HTTPServer#start: pid=30080 port=4567
```

### with docker

Just fire up `docker-compose`

```
docker-compose up
```