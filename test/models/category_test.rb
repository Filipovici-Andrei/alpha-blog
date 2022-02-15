require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'Category should be valid' do
    @category = Category.new(name: 'sports')
    assert @category.valid?
  end
end
