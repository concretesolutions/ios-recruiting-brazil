# Movie Database

### Environment

**TheMovieDatabase API Key (required)**

1. [Creat an account at themoviedb](https://www.themoviedb.org/login)
2. Get your **API Read Access Token (v4 auth)** from [themoviedb](https://www.themoviedb.org/settings/api)
3. Run `cp _ApiKey.swift ApiKey.swift`
4. Open `ApiKey.swift` and add your api key

**Ruby and Fastlane**

1. Install a ruby verson manager of your preference: [chruby](https://github.com/postmodern/chruby) + [ruby-install](https://github.com/postmodern/ruby-install), [rbenv](https://github.com/rbenv/rbenv), or [rvm](https://github.com/rvm/rvm).
2. Install the ruby-version specified in the [.ruby-versoin](.ruby-verson) file.
3. Make sure you're using the currect ruby version by runninig `ruby -v`
4. Install bundler by running `gem install bundler`
5. Install gems `bundle install`

**Node (optional)**

We use husky to setup git hooks. To use husky you'll need to have a node environment setup. 

1. Install and setup [nvm](https://github.com/nvm-sh/nvm)
2. Install the node version specified on [.nvmrc](.nvmrc)
3. run `npm install`

**Mint and Swift Packages (optional)**

1. Install and setup [Mint](https://github.com/yonaskolb/Mint#installing)
2. run `mint bootstrap`

