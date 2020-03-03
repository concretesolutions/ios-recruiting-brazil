# Travis CI
if [ ! -z "$ON_CI" ]; then
    gem install bundler:2.0.2
fi

# Dependencies
carthage bootstrap --platform ios --cache-builds
bundle install
