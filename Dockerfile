FROM ruby:2.4

RUN apt-get update && apt-get install -y python python-dev build-essential python-pip git libxml2-dev libxslt-dev libgmp3-dev
RUN pip install boto s3cmd

COPY fakes3.gemspec Gemfile Gemfile.lock /app/
COPY lib/fakes3/version.rb /app/lib/fakes3/

WORKDIR /app

RUN bundle install

COPY . /app/

RUN mkdir -p /fakes3_storage
ENTRYPOINT ["/app/bin/fakes3"]
CMD ["-r",  "/fakes3_storage", "-p",  "4569"]
EXPOSE 4569
