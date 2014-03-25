require 'test_helper'


class CategoryTest < ActiveSupport::TestCase

  def test_save_success
    category = Category.new(name: 'awesome')
    assert_equal category.save,
      category.errors.full_messages.join(', ')
  end

  def test_save_failure
    category = Category.new
    refute category.save
    assert_equal ["can't be blank", "is not awesome"],
      category.errors[:name]
  end
end
