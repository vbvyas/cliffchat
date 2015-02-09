# cliffchat

[http://www.cliffchat.com](http://www.cliffchat.com)

Cliffchat is a place where you get your questions answered, answer others questions, and help each other out.

### Requirements:

  Requires postgresql

  To use sqllite. Replace this in your Gemfile:
  gem 'pg' => gem 'sqlite3'

  In your config/database.yml replace the adapter, and database:
  postgresql => sqlite3
  cliffchat_development => db/development.sqlite3

### Install:

    git clone https://github.com/vbvyas/cliffchat.git
    cd cliffchat
    bundle install
    bundle exec rake db:migrate

### Run:

    rails server

### Navigate to:

  [http://localhost:3000](http://localhost:3000)
