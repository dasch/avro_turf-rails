class GroupsController < ApplicationController
  avro_schema :group

  def show
    @group = { "name" => "VIP" }
  end

  def create
    @group = params[:group]

    render avro: @group, status: :created
  end
end
