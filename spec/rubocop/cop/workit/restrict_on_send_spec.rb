# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Workit::RestrictOnSend, :config do
  it "registers an offense when using only `on_send`" do
    expect_offense(<<~RUBY)
      class FooCop
      ^^^^^^^^^^^^ Consider defined `RESTRICT_ON_SEND` for optimization.
        extend AutoCorrector
        def on_send(node)
          # ...
        end
      end
    RUBY
  end

  it "registers an offense when using only `after_send`" do
    expect_offense(<<~RUBY)
      class FooCop
      ^^^^^^^^^^^^ Consider defined `RESTRICT_ON_SEND` for optimization.
        def after_send(node)
          # ...
        end
      end
    RUBY
  end

  it "does not register an offense when not in class" do
    expect_no_offenses(<<~RUBY)
      def on_send(node)
        # ...
      end
    RUBY
  end

  it "does not register an offense when module" do
    expect_no_offenses(<<~RUBY)
      module FooCop
        def on_send(node)
          # ...
        end
      end
    RUBY
  end

  it "does not register an offense when using `RESTRICT_ON_SEND` and defines `on_send`" do
    expect_no_offenses(<<~RUBY)
      class FooCop
        RESTRICT_ON_SEND = %i[bad_method].freeze
        def on_send(node)
          # ...
        end
      end
    RUBY
  end

  it "does not register an offense when using other than `on_send` and `after_send`" do
    expect_no_offenses(<<~RUBY)
      class FooCop
        def on_def(node)
          # ...
        end
      end
    RUBY
  end
end
