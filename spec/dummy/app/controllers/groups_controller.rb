class GroupsController < ApplicationController
  schema :group

  def show
    @group = { "name" => "VIP" }
  end

  def create
    @group = params[:group]

    render status: :created
  end
end
