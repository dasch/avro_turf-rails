class AvroTurf::Rails::TemplateResolver < ActionView::Resolver
  def initialize(schemas_path:)
    super()
    @schemas_path = schemas_path
  end

  def find_templates(name, prefix, partial, details)
    return [] unless details.fetch(:formats).include?(:avro)

    details = {
      format: :avro,
      virtual_path: ActionView::Resolver::Path.build(name, prefix, partial).to_str,
    }

    handler = lambda do |template|
      <<-RUBY
        schema_name = self.controller.avro_schema
        data = instance_variable_get("@" << schema_name)

        @avro ||= AvroTurf.new(schemas_path: "#{@schemas_path}")
        @avro.encode(data, schema_name: schema_name)
      RUBY
    end

    template = ActionView::Template.new("", "Avro template", handler, details)
    return [template]
  end
end
