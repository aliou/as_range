require 'as_range/version'

module AsRange
  class Error < StandardError; end

  def self.included(base)
    base.extend AsRange::ClassMethods
  end

  module ClassMethods
    DEFAULT_OPTIONS = {
      start: :start_date,
      end: :end_date,
      method_name: :as_range,
      include_end: true
    }.freeze

    def as_range(options = {})
      options = DEFAULT_OPTIONS.merge(options)
      start_attribute = options[:start]
      end_attribute = options[:end]

      define_method options[:method_name] do
        start_value = start_attribute.call if start_attribute.respond_to?(:call)
        start_value ||= public_send(start_attribute)

        end_value = end_attribute.call if end_attribute.respond_to?(:call)
        end_value ||= public_send(end_attribute)

        Range.new(start_value, end_value, !options[:include_end])
      end
    end
  end
end
