# frozen_string_literal: true

class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :notes, :solved
end
