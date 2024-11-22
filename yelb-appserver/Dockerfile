FROM bitnami/ruby:2.7.4
LABEL maintainer="massimo@it20.info"

################## BEGIN INSTALLATION ######################

# Set the working directory to /app
WORKDIR /app

COPY *.rb ./
COPY Gemfile Gemfile
COPY modules modules

ENV LANG=en_us.UTF-8
ENV LC_ALL=C.UTF-8
ENV RACK_ENV=production

RUN gem install sinatra:3.2.0 --no-document && \
    gem install redis:5.3.0 --no-document
### hack to allow the setup of the pg gem (which would fail otherwise)
RUN apt-get update && \
    apt-get install --no-install-recommends libpq-dev=11.22-0+deb10u2 -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
### end of hack (this would require additional research and optimization)
RUN gem install pg:1.5.9 --no-document && \
    gem install aws-sdk-dynamodb:1.130.0 pg:1.5.9 --no-document
# Set the working directory to /
WORKDIR /
COPY startup.sh startup.sh

# Lambda adapter
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.5.1 /lambda-adapter /lambda-adapter

# Setup Lambda RIE + RIC
RUN curl -L -o /usr/bin/lambda_rie https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/download/v1.9/aws-lambda-rie-x86_64 && \
    chmod +x /usr/bin/lambda_rie && \
    gem install aws_lambda_ric:2.0.0

##################### INSTALLATION END #####################

CMD ["./startup.sh"]