FROM bitnami/ruby:2.4.2-r1

LABEL maintainer="massimo@it20.info"

WORKDIR /app

COPY yelb-appserver.rb yelb-appserver.rb
COPY Gemfile Gemfile
COPY modules modules

ENV LANG=en_us.UTF-8
ENV LC_ALL=C.UTF-8
ENV RACK_ENV=production

RUN apt-get update && \
    apt-get install --no-install-recommends -y libpq-dev && \
    gem install sinatra -v '2.0.0' --no-ri --no-rdoc && \
    gem install redis -v '4.0.0' --no-ri --no-rdoc && \
    gem install pg -v '1.2.3' --no-ri --no-rdoc && \
    gem install aws-sdk-dynamodb -v '1.0.0' --no-ri --no-rdoc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /
COPY startup.sh startup.sh

CMD ["./startup.sh"]
