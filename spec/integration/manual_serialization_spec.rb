describe "Manual serialization", type: :request do
  let(:avro) { AvroTurf.new(schemas_path: "spec/dummy/app/schemas") }

  example "encoding response bodies with Avro" do
    get "/people/john", {}, { "HTTP_ACCEPT" => "avro/binary" }

    body = avro.decode(response.body, schema_name: "person")
    expect(body).to eq({ "name" => "John", "age" => 42 })
  end

  example "decoding request bodies encoded with Avro" do
    data = { "name" => "John", "age" => 42 }
    body = avro.encode(data, schema_name: "person")

    post "/people", body, { "Content-Type" => "avro/binary", "HTTP_ACCEPT" => "avro/binary" }

    expect(response.status).to eq 201
  end
end
