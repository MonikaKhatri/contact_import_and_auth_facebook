class EmailValidator < ActiveModel::EachValidator
  def validate_each( record, attribute, value )
    valid = EmailVerifier.check(value)
    if valid == false
      record.errors[attribute] << (options[:message] || "address does not exists")
    end
    rescue EmailVerifier::FailureException
      record.errors[attribute] << (options[:message] || "address invalid")
    rescue EmailVerifier::OutOfMailServersException
      record.errors[attribute] << (options[:message] || "address invalid")
    rescue Net::SMTPFatalError
      record.errors[attribute] << (options[:message] || "address invalid")
    rescue EmailVerifier::NoMailServerException
      record.errors[attribute] << (options[:message] || "address invalid")
    rescue EmailVerifier::NotConnectedException
      record.errors[attribute] << (options[:message] || "address invalid")
  end
end