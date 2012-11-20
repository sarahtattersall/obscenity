if defined?(ActiveModel)
  module ActiveModel
    module Validations
      class ObscenityValidator < ActiveModel::EachValidator

        def validate_each(record, attribute, value)
          if options.present? && options.has_key?(:sanitize)
            object = record.respond_to?(:[]) ? record[attribute] : record.send(attribute)
            object = Obscenity.replacement(options[:replacement]).sanitize(object)
          else
            if options.present? && options.has_key?(:partial)
              profane = Obscenity.profane?(value, options[:partial])
            else
              profane = Obscenity.profane?(value)
            end
            record.errors.add(attribute, options[:message] || 'cannot be profane') if profane
          end
        end

      end
    end
  end
end
