# Trailblazer::Compat

This gem provides a seamless-er™ upgrade from TRB 1.1 to 2.x.

It allows to run both old TRB 1.1 operations along with new or refactored 2.x code in the same application, making it easier to upgrade operation code `step`-wise (no pun intended!) or add new TRB2 operations, workflows, etc. without having to change the old code.

## Installation

Your exisiting application's `Gemfile` should point to the new `trailblazer` gem.

```ruby
gem "trailblazer", ">= 2.0.0"
gem "trailblazer-compat"
```

In a Rails application, you also need to pull the 1.x line of the `trailblazer-rails` gem.

```ruby
gem "trailblazer-rails", ">= 1.0.0"
```

## Upgrade Path / Overview

The complete migration path is [documented here](http://trailblazer.to/gems/trailblazer/upgrading-1-to-2.html).

1. You can keep old TRB1 operations.

    ```ruby
    # /app/concepts/song/create.rb
    class Song
      class Create < Trailblazer::Operation
        model Song, :create
        policy Song::Policy, :admin?

        contract do
          property :id
          # ...
        end

        def process(params)
          validate(params[:song]) do |form|
            form.save
          end
        end
      end
    end
    ```
2. At any point, you can introduce new TRB2 operations or update old classes by inheriting from `Trailblazer::Operation.version(2)`.

    ```ruby
    # /app/concepts/song/create.rb
    class Song
      class Create < Trailblazer::Operation.version(2)
        class Form < Reform::Form
          property :id
          # ...
        end

        class New < Trailblazer::Operation.version(2)
          step Model( Song, :new )
          step Policy::Pundit( Song::Policy, :admin? )
          step Contract::Build( constant: Form )
        end

        step Nested(New)
        step Contract::Validate( key: :admin )
        step Contract::Persist()
      end
    end
    ```

3. Should you ever be finished updating your application, simply remove the `trailblazer-compat` gem from the `Gemfile`. You can then safely delete `.version(2)` across all files.

## Development Status

The `compat` gem tries to make the transition to newer versions as painless as possible. However, if you run into any problems specific to your application, please [don't hesitate to contact us](https://gitter.im/trailblazer/chat). Pull requests (even ugly hacks) are appreciated in this gem, and this gem only.
