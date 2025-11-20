# == Schema Information
#
# Table name: apps
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_apps_on_name  (name) UNIQUE
#
class AppSerializer < ApplicationSerializer
  def as_json(*)
    {
      id: record.id,
      type: "app",
      name: record.name
    }
  end
end
