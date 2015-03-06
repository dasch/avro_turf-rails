class PeopleController < ApplicationController
  def show
    @person = { "name" => "John", "age" => 42 }

    respond_to do |format|
      format.avro { render avro: @person, schema_name: "person" }
    end
  end

  def create
    avro = AvroTurf.new(schemas_path: Rails.root.join("app/schemas"))

    @person = avro.decode(request.body.string, schema_name: "person")

    respond_to do |format|
      format.avro { render avro: @person, schema_name: "person", status: :created }
    end
  end
end
