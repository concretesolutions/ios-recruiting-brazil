# Travis CI
if [ ! -z "$ON_CI" ]; then
    bundle update --bundler
fi

# Dependencies
carthage bootstrap --platform ios --cache-builds
bundle install
