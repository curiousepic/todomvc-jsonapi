class TodoSerializer < ActiveModel::Serializer

  def default_serializer_options
    {root: false}
  end

  attributes :id, :title, :order
end
