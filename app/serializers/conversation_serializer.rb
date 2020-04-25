class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :notes, :solved
end
