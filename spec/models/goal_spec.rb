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

require 'rails_helper'

RSpec.describe Goal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:details) }
    it { should validate_presence_of(:private) }
    it { should validate_presence_of(:completed) }
    it { should validate_presence_of(:user) }
  end

  describe "assocations" do
    it { should belong_to(:user) }
  end
end
