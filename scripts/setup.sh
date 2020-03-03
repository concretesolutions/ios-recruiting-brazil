# Travis CI
if ON_CI == 1; then
    bundle update --bundler
fi

# Dependencies
carthage bootstrap --platform ios --cache-builds --no-use-binaries
bundle install
