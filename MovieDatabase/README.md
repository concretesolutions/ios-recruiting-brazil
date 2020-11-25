# Movie Database

### Instructions

**TheMovieDatabase API Key**

1. [Creat an account at themoviedb](https://www.themoviedb.org/login)
2. Get your **API Read Access Token (v4 auth)** from [themoviedb](https://www.themoviedb.org/settings/api)
3. Run `cp _ApiKey.swift ApiKey.swift`
4. Open `ApiKey.swift` and add your api key

**Ruby and Fastlane**

1. (optional) Install a ruby verson manager of your preference: [chruby](https://github.com/postmodern/chruby) + [ruby-install](https://github.com/postmodern/ruby-install), [rbenv](https://github.com/rbenv/rbenv), or [rvm](https://github.com/rvm/rvm).
2. Install the ruby-version specified in the [.ruby-versoin](.ruby-verson) file.
3. Make sure you're using the currect ruby version `ruby -v`
4. Install bundler `gem install bundler`
5. Install gems `bundle install`

**Node**

We use husky to setup git hooks. To use husky you'll need to node and npm installed. 

1. (optional) Install and setup [nvm](https://github.com/nvm-sh/nvm)
2. Install the node version specified on [.nvmrc](.nvmrc)
3. Install packages `npm install`

**Mint and Swift Packages**

We use SwiftGen to generate code for assets and SwiftFormat to format the code. To use them you'll need Mint installed.

1. Install [Mint](https://github.com/yonaskolb/Mint#installing)
2. Install packages `mint bootstrap`

