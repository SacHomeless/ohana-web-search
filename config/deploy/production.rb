role :app, %w{sacsos}
role :web, %w{sacsos}
role :db, %w{sacsos}

server 'sacsos', roles: %w{web app db}
