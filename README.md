# Word Counter

Welcome to your new Hanami project!

## Quickstart

```
% make install
% make update
% make status

```

As outcome you should get something similar to:

```
       Name                      Command               State                    Ports
-------------------------------------------------------------------------------------------------------
word_counter_app      bundle exec puma -C config ...   Up      0.0.0.0:7000->7000/tcp
word_counter_redis    docker-entrypoint.sh redis ...   Up      0.0.0.0:6379->6379/tcp
word_counter_web      nginx -c /etc/nginx/nginx.conf   Up      0.0.0.0:443->443/tcp, 0.0.0.0:81->81/tcp
word_counter_worker   bundle exec sidekiq -e dev ...   Up
```

How to run the development console:

```
% make console
```

How to run the development server:

```
% docker-compose up
```

## API call examples

### API calls to populate data

```
curl -X POST \
  http://localhost:81/counters \
  -F url=https://gist.githubusercontent.com/darrenjaworski/5eb74c87bb42fc514e41/raw/36ad23f28371dea2ee10b19341d0e5d530b7c93c/oupayroll.txt
```

```
curl -X POST \
  http://localhost:81/counters \
  -F server_file=/var/www/word_counter/log/nginx-access.log
```

```
curl -X POST \
  'http://localhost:81/counters?text=whales'
```

### Search API calls

```
curl -X GET \
  'http://localhost:81/counters?text=get'
```