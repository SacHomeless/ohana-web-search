FROM ubuntu:17.10

RUN apt-get update

RUN apt-get install -y openssh-server git-core openssh-client curl vim build-essential \
    openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev \
    libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake \
    libtool bison pkg-config gawk libgdbm-dev libgmp-dev libgdm-dev libffi-dev libpq-dev \
    postgresql-client nodejs ruby ruby-dev npm libfontconfig

RUN npm install -g phantomjs
RUN gem install bundler

RUN adduser --disabled-password sacsos

USER sacsos

RUN mkdir /home/sacsos/web

WORKDIR /home/sacsos/web

COPY . /home/sacsos/web/
USER root
RUN  chown -R sacsos /home/sacsos/web
USER sacsos

RUN echo "gem: --no-document" > /home/sacsos/.gemrc
RUN bundle --path /home/sacsos/.bundled_gems

RUN /bin/bash -l -c "sed -i 's/sacsos.org/lvh.me:3000/g' app/helpers/homepage_links_helper.rb"
RUN /bin/bash -l -c "sed -i 's/sacsos.org/ohana-api.dev:3000/g' app/controllers/home_controller.rb"

EXPOSE 3000

CMD /bin/bash -l -c "rm -f tmp/pids/server.pid && rails s -b 0.0.0.0"
