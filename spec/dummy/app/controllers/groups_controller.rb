class GroupsController < ApplicationController
  schema :group

  def create
    @group = params.fetch(:group)

    raise unless @group.key?(:name)

    head :created
  end

  def update
    head :ok
  end
end
