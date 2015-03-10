module AvroTurf::Rails::AvroHelpers
  extend ActiveSupport::Concern

  included do
    before_filter :decode_avro_params
  end

  def avro_schema
    self.class.schema
  end

  private

  def decode_avro_params
    schema_name = avro_schema

    return unless request.content_mime_type.avro?
    return if request.body.eof?
    return if schema_name.nil?
    return unless request.post? || request.put?

    avro = AvroTurf.new(schemas_path: Rails.root.join("app/schemas"))
    decoded_data = avro.decode(request.body.string, schema_name: schema_name)
    params[schema_name] = decoded_data
  end

  module ClassMethods
    def schema(name = nil)
      @avro_schema = name.to_s if name
      @avro_schema
    end
  end
end
