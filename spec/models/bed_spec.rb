# == Schema Information
#
# Table name: beds
#
#  id         :bigint           not null, primary key
#  room_id    :bigint           not null
#  bed_size   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Bed, type: :model do
  context 'validations' do
    it { should validate_presence_of(:bed_size) }
  end

  context 'associations' do
    it { should belong_to(:room) }
  end
end
