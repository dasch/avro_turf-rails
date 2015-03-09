describe "Automatic serialization", type: :request do
  let(:avro) { AvroTurf.new(schemas_path: "spec/dummy/app/schemas") }

  example "encoding response bodies with Avro" do
    get "/groups/vip", {}, { "HTTP_ACCEPT" => "avro/binary" }

    body = avro.decode(response.body, schema_name: "group")
    expect(body).to eq({ "name" => "VIP" })
  end

  example "decoding request bodies encoded with Avro" do
    data = { "name" => "VIP" }
    body = avro.encode(data, schema_name: "group")

    post "/groups", body, { "Content-Type" => "avro/binary", "HTTP_ACCEPT" => "avro/binary" }

    body = avro.decode(response.body, schema_name: "group")
    expect(body).to eq({ "name" => "VIP" })
    expect(response.status).to eq 201
  end
end
