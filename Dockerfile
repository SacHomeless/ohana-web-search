FROM ubuntu

RUN apt-get update

RUN apt-get install -y openssh-server git-core openssh-client curl
RUN apt-get install -y vim
RUN apt-get install -y build-essential
RUN apt-get install -y openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison pkg-config
RUN apt-get install -y gawk libgdbm-dev libgmp-dev libgdm-dev libffi-dev

RUN adduser --disabled-password sacsos

USER sacsos

RUN mkdir /home/sacsos/web

WORKDIR /home/sacsos/web

# install RVM, Ruby, and Bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm install --autolibs=fail 2.2.3"
RUN /bin/bash -l -c "echo 'gem: --no-document' > ~/.gemrc"

COPY . /home/sacsos/web/
USER root
RUN chown -R sacsos /home/sacsos/web
USER sacsos

# run git clone https://github.com/SacHomeless/ohana-web-search.git .

RUN /bin/bash -l -c "rvm gemset create ohana-web-search"
RUN /bin/bash -l -c "rvm gemset use ohana-web-search && gem install bundler && bundle install"
RUN /bin/bash -l -c "sed -i 's/sacsos.org/lvh.me:3000/g' app/helpers/homepage_links_helper.rb"
RUN /bin/bash -l -c "sed -i 's/sacsos.org/ohana-api.dev:3000/g' app/controllers/home_controller.rb"

EXPOSE 3000

CMD /bin/bash -l -c "rm -f tmp/pids/server.pid && rails s -b 0.0.0.0"
