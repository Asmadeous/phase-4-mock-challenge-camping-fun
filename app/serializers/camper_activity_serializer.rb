class CamperActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :age
  has_many :activities do
    object.activities.select(:id, :name, :difficulty)
  end
end
