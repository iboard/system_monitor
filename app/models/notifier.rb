class Notifier < ActionMailer::Base

  def alert(from,email,subject,message,monitor)
    subject     subject
    from        from
    recipients  email
    body        :message => message, :monitor => monitor
    content_type "text/html"
  end

end
