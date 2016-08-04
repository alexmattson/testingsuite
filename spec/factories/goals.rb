# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  private    :boolean          default(FALSE), not null
#  completed  :boolean          default(FALSE), not null
#  user_id    :integer          not null
#  title      :string           not null
#  details    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    title {Faker::Hipster.sentence}
    details {Faker::Lorem.paragraph}
    user_id {User.all.sample.id}
  end
end
