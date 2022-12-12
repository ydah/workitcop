# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Workit::ComitteeAssertSchemaConfirm, :config do
  it "registers an offense and autocorrects when using `assert_schema_conform` " \
     "with no argument and `have_http_status`" do
    expect_offense(<<~RUBY)
      it 'something' do
        subject
        expect(response).to have_http_status 400
        do_something
        assert_schema_conform
        ^^^^^^^^^^^^^^^^^^^^^ Pass expected response status code to check it against the corresponding schema explicitly.
      end
    RUBY

    expect_correction(<<~RUBY)
      it 'something' do
        subject
        do_something
        assert_schema_conform(400)
      end
    RUBY
  end

  it "registers an offense when using `assert_schema_conform` " \
     "with no argument" do
    expect_offense(<<~RUBY)
      it 'something' do
        subject
        do_something
        assert_schema_conform
        ^^^^^^^^^^^^^^^^^^^^^ Pass expected response status code to check it against the corresponding schema explicitly.
      end
    RUBY

    expect_no_corrections
  end

  it "does not register an offense and autocorrects when using `assert_schema_conform` " \
     "with http status code" do
    expect_no_offenses(<<~RUBY)
      it 'something' do
        subject
        assert_schema_conform(400)
      end
    RUBY
  end

  it "registers an offense and autocorrects when using `assert_response_schema_confirm` " \
     "with no argument" do
    expect_offense(<<~RUBY)
      it 'something' do
        subject
        expect(response).to have_http_status 400
        do_something
        assert_response_schema_confirm
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Pass expected response status code to check it against the corresponding schema explicitly.
      end
    RUBY

    expect_correction(<<~RUBY)
      it 'something' do
        subject
        do_something
        assert_response_schema_confirm(400)
      end
    RUBY
  end

  it "does not register an offense when using `assert_response_schema_confirm` " \
     "with http status code" do
    expect_no_offenses(<<~RUBY)
      it 'something' do
        subject
        assert_response_schema_confirm(400)
      end
    RUBY
  end
end
