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
class Order < ApplicationRecord
  after_create_commit { broadcast_append_to "orders" }
  after_update_commit { broadcast_replace_to "orders" }
  after_destroy_commit { broadcast_remove_to "orders" }

end
