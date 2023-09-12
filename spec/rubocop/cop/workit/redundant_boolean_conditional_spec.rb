# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Workit::RedundantBooleanConditional, :config do
  it "registers an offense for if with true results" do
    expect_offense(<<~RUBY)
      true if x == y
      ^^^^^^^^^^^^^^ This conditional expression can just be replaced by `x == y`.
    RUBY

    expect_correction(<<~RUBY)
      x == y
    RUBY
  end

  it "registers an offense for if with false results" do
    expect_offense(<<~RUBY)
      false if x == y
      ^^^^^^^^^^^^^^^ This conditional expression can just be replaced by `!(x == y)`.
    RUBY

    expect_correction(<<~RUBY)
      !(x == y)
    RUBY
  end

  it "registers an offense for unless with true results" do
    expect_offense(<<~RUBY)
      true unless x == y
      ^^^^^^^^^^^^^^^^^^ This conditional expression can just be replaced by `!(x == y)`.
    RUBY

    expect_correction(<<~RUBY)
      !(x == y)
    RUBY
  end

  it "registers an offense for unless with false results" do
    expect_offense(<<~RUBY)
      false unless x == y
      ^^^^^^^^^^^^^^^^^^^ This conditional expression can just be replaced by `x == y`.
    RUBY

    expect_correction(<<~RUBY)
      x == y
    RUBY
  end

  it "registers an offense for if block with true results" do
    expect_offense(<<~RUBY)
      if x == y
      ^^^^^^^^^ This conditional expression can just be replaced by `x == y`.
        true
      end
    RUBY

    expect_correction(<<~RUBY)
      x == y
    RUBY
  end

  it "registers an offense for if block with false results" do
    expect_offense(<<~RUBY)
      if x == y
      ^^^^^^^^^ This conditional expression can just be replaced by `!(x == y)`.
        false
      end
    RUBY

    expect_correction(<<~RUBY)
      !(x == y)
    RUBY
  end

  it "registers an offense for unless block with true results" do
    expect_offense(<<~RUBY)
      unless x == y
      ^^^^^^^^^^^^^ This conditional expression can just be replaced by `!(x == y)`.
        true
      end
    RUBY

    expect_correction(<<~RUBY)
      !(x == y)
    RUBY
  end

  it "registers an offense for unless block with false results" do
    expect_offense(<<~RUBY)
      unless x == y
      ^^^^^^^^^^^^^ This conditional expression can just be replaced by `x == y`.
        false
      end
    RUBY

    expect_correction(<<~RUBY)
      x == y
    RUBY
  end
end
