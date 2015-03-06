class AvroTurf
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'avro_turf.initialize_avro_serialization' do
        Mime::Type.register "avro/binary", :avro

        avro = AvroTurf.new(schemas_path: ::Rails.root.join("app", "schemas"))

        ActionController::Renderers.add :avro do |data, options|
          schema_name = options.fetch(:schema_name) { raise "please pass a schema name" }
          encoded_data = avro.encode(data, schema_name: schema_name)

          send_data encoded_data, type: "avro/binary"
        end
      end
    end
  end
end
