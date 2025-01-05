class EmailValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    return if object.try(:skip_valid_email) == true

    object.errors.add(attribute, options[:message] || "only allows valid emails") if value.nil? || !Truemail.valid?(value.to_s)
  end

  def self.validate_single(email)
    return false if email.nil?

    Truemail.valid?(email)
  end

  def self.validate_basic(email)
    return false if email.nil?

    Truemail.valid?(email, with: :regex)
  end
end
