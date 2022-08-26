# Workitcop [![Gem Version](https://badge.fury.io/rb/workitcop.svg)](https://badge.fury.io/rb/workitcop) [![CI](https://github.com/ydah/workitcop/actions/workflows/ci.yml/badge.svg)](https://github.com/ydah/workitcop/actions/workflows/ci.yml) [![Maintainability](https://api.codeclimate.com/v1/badges/77fd345a1f0e8ab706ed/maintainability)](https://codeclimate.com/github/ydah/workitcop/maintainability)

Custom cops for [RuboCop](https://github.com/rubocop/rubocop).

## Installation

Install the gem and add to the application's Gemfile by executing:

```command
bundle add workitcop
```

If bundler is not being used to manage dependencies, install the gem by executing:

```command
gem install workitcop
```

## Usage

You need to tell RuboCop to load the Workitcop extension.

### RuboCop configuration file

Put this into your `.rubocop.yml`.

```yaml
require: workitcop
```

Alternatively, use the following array notation when specifying multiple extensions.

```yaml
require:
  - rubocop-other-extension
  - workitcop
```

Now you can run `rubocop` and it will automatically load the Workitcop
cops together with the standard cops.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
