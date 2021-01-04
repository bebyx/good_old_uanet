# База старих сайтів

Веб-застосунок для бази старих сайтів УАнету.

https://io.bebyx.co.ua/uanet

* Ruby: **2.7.2**

## Deploy

Install RVM.

Install Ruby:

```bash
rvm install 2.7.2`
```

Install gems:

```bash
bundle install
```

Setup db:

```bash
RAILS_ENV=production rails db:migrate
RAILS_ENV=production rails db:seed
```

Setup credentials (recaptcha).

Run rails server as daemon:

```bash
RAILS_ENV=production rails s -b 127.0.0.1 -d
```

Remember to setup webserver (e.g. nginx) to listen to local 3000 port.
