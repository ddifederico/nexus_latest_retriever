# NexusLatestRetriever

Due to limitations with current version of Nexus 3, here's a script to retrieve the latest version of a given artefact. It works with releases and snapshots.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nexus_latest_retriever'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nexus_latest_retriever

## Usage
Using the executable `nlr` is the preferred way:

Usage: nlr [OPTIONS]

Mandatory:
    -a, --artifact-id ARTIFACT_ID    The artifactId of the package to find.
    -g, --group-id GROUP_ID          The groupId of the package to find.
    -n, --nexus NEXUS_HOST           Nexus host.
    -r, --repository REPOSITORY      The repository to use to find the package.

Optional:
    -c, --classifier CLASSIFIER      The package classifier to find. Default: no classifier.
    -e, --extension EXTENSION        The package extension to find. Default: jar
    -o, --output OUTPUT              The output file. Default: original filename
    -p, --port PORT                  Nexus port. Default 80.
    -s, --scheme SCHEME              The protocol scheme to use. Default http.
    -v, --verbose                    The protocol scheme to use. Default false.
    -h, --help                       Show this message

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ddifederico/nexus_latest_retriever.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

