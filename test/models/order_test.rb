# == Schema Information
#
# Table name: orders
#
#  id            :bigint           not null, primary key
#  customer_name :string
#  name          :string
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  airtable_id   :string
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
