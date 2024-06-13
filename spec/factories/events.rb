# == Schema Information
#
# Table name: events
#
#  id            :bigint           not null, primary key
#  request_body  :text
#  status        :integer          default("pending")
#  source        :string
#  error_message :text
#  event_type    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :event do
    request_body { "MyText" }
    status { 1 }
    source { "MyString" }
    error_message { "MyText" }
    event_type { "MyString" }
  end
end
