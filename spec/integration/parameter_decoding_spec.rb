# See spec/dummy/app/controllers/groups_controller.rb
describe "Parameter decoding", type: :request do
  let(:avro) { AvroTurf.new(schemas_path: "spec/dummy/app/schemas") }

  it "decodes request bodies encoded with Avro" do
    data = { "name" => "VIP" }
    body = avro.encode(data, schema_name: "group")

    post "/groups", body, { "Content-Type" => "avro/binary" }

    expect(response.status).to eq 201
  end

  it "ignores empty request bodies" do
    put "/groups/42", nil, { "Content-Type" => "avro/binary" }

    expect(response.status).to eq 200
  end
end
