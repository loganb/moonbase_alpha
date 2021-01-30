# MoonbaseAlpha

Moonbase Alpha rolls up everything you need to build a Rails app into a docker image ready to deploy on AWS Lambda. It is based heavily on (and uses) [Lamby](http://lamby.custominktech.com), which requires even fewer steps to launch a project, but unlike Lamby, Moonbase Alpha does not use any of AWS' SAM tooling. Moonbase Alpha is ideal for cases where you want more control over orchestration or to integrate with other tools. 

Using Moonbase Alpha, a blank rails app builds into a ~120MB docker image, and the final image is constructed in stages to minimize the build tools that leak into the production environment. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'moonbase_alpha'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install moonbase_alpha

Then use the generator to create the configuration files and `app.rb` entrypoint: 

    $ bin/rails g moonbase

## Usage

You must set at least one value in `moonbase_alpha.yml` prior to building your project, the docker repository, such as: 

    # Repository for the build. A build number will be set as the version
    repository: 134567895209.dkr.ecr.us-west-2.amazonaws.com/dockertest

You can control which Alpine Linux packages are available at build time (both gems and assets) and at run time. The defaults should be sufficient to build a basic Rails app. 

To build an image, run `bin/rails moonbase_alpha:build`. Moonbase Alpha includes rake tasks that output the last build tag and the full repository name. To push the current image, for example, invoke: 

    $ docker push `bin/rails moonbase_alpha:latest_image`
    The push refers to repository [134567895209.dkr.ecr.us-west-2.amazonaws.com/dockertest]
    5d6180898fe9: Pushed
    9d6fac557487: Pushed
    4b60b0d829a4: Pushed
    ae7119e06cea: Pushed
    84cbece2f061: Pushed
    745332470db1: Pushed
    93a2bfafa84f: Pushed
    54f362ba164c: Pushed
    c4b1ff92c516: Pushed
    446d8e2016ac: Pushed
    50644c29ef5a: Pushed
    build-2021-01-30-12-22-22: digest: sha256:41c633b81b41d107fdc15740d1e68e3f8cfcfbf4dfb8d54428fe07e748427f42 size: 2618


## Development

This is a relatively simple project I put together mostly to accelerate my own workflows. It is missing some functionality and patches are welcome. The following items are outstanding: 

* Setup automated testing
* Definitively handle asset compilation (more or less stubbed out right now because my use case is as an API project only)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/loganb/moonbase_alpha. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/loganb/moonbase_alpha/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MoonbaseAlpha project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/loganb/moonbase_alpha/blob/master/CODE_OF_CONDUCT.md).
