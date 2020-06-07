# as\_range

Removes the boilerplate of working with objects representing ranges.

Instead of

```ruby
class Period
  def initialize(period_start, period_end)
    @period_start = period_start
    @period_end = period_end
  end

  def as_range
    @period_start..@period_end
  end
end
```

With `as_range`, you can do:

```ruby
class Period
  as_range

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end
end
```

## Usage

### Using with custom attributes

By default, `as_range` will generate a range using `start_date` and `end_date` as the bound of the range. You can customize this behavior by passing a symbol to the `:start` and `:end` options:

```ruby
class Period
  attr_reader :period_start
  as_range start: :period_start, end: :compute_period_end

  def initialize(period_start)
    @period_start = period_start
  end

  def compute_period_end
    period_start + 1.year
  end
end
```

The `:start` and `:end` also accept a `proc`:
```ruby
class Period
  attr_reader :period_start
  as_range start: :period_start, end: -> { period_start + 1.year }

  def initialize(period_start)
    @period_start = period_start
  end
end
```

### Excluding the end of the range

By default, the generated range includes the end of the range. To exclude the end, set the `include_end` option to `false`:

```ruby
class Period
  attr_reader :period_start
  as_range include_end: false

  def start_date
    Date.new(2020, 1, 1)
  end

  def end_date
    Date.new(2021, 1, 1)
  end
end
> p = Period.new
> p.as_range
# => #<Date: 2020-01-01>...#<Date: 2021-01-01> # Note the extra dot.

```

### Customizing the method name

By default, it names the generated method `as_range`. To set a custom method name, use the `method_name` option:
```ruby
class Period
  as_range method_name: :to_range

  def start_date
    Date.new(2020, 1, 1)
  end

  def end_date
    Date.new(2021, 1, 1)
  end
end

> p = Period.new
> p.to_range
# => #<Date: 2020-01-01>..#<Date: 2021-01-01> # Note the extra dot.
```

## Explicit mode

By default, `as_range` will add methods to every class and module.

This is not ideal if you're using `as_range` in a library: those who depend on your library will get those methods as well.

It's also not obvious where the methods come from. You can be more explicit about it, and restrict where the methods are added, like this:

``` ruby
require "as_range/explicit"

class MyPeriod
  extend AsRange.explicit

  as_range method_name: :now_this_class_can_use_as_range
end
```

Crucially, you need to `require "as_range/explicit"` *instead of* `require "as_range"`. Some frameworks, like Ruby on Rails, may automatically require everything in your `Gemfile`. You can avoid that with `gem "as_range", require: "as_range/explicit"`.

In explicit mode, you need to call `extend AsRange.explicit` *in every class or module* that wants the `as_range` methods.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'as_range'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install as_range

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Acknowledgements
`as_range`'s explicit mode is directly inspired by [`attr_extras`](https://github.com/barsoom/attr_extras/).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/aliou/as_range>

## License

[MIT](LICENSE.txt)
