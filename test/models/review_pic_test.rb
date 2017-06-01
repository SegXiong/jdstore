# == Schema Information
#
# Table name: review_pics
#
#  id         :integer          not null, primary key
#  review_id  :integer
#  avatar     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ReviewPicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
