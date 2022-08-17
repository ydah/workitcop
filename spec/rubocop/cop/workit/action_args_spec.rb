# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Workit::ActionArgs, :config do
  let(:cop_config) do
    { "ControllerMethods" => %w[index] }
  end

  it "registers an offense when not using `action_args`" do
    expect_offense(<<~RUBY)
      class FooController
        def index
        ^^^^^^^^^ Consider using `action_args`.
          # ...
        end
      end
    RUBY
  end

  it "does not register an offense when using `action_args`" do
    expect_no_offenses(<<~RUBY)
      class FooController
        def index(foo:)
          # ...
        end
      end
    RUBY
  end

  it "does not register an offense when a method name is not included in `ControllerMethods`." do
    expect_no_offenses(<<~RUBY)
      class FooController
        def other_method
          # ...
        end
      end
    RUBY
  end
end
