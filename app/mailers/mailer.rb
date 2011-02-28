class Mailer < Devise::Mailer

  def reset_password_instructions(record)
    attachments.inline['jumpingfrog.jpg'] = File.read(Rails.root.join('public/images/jumpingfrog.gif'))
    # Call up to Devise::Mailer method:
    setup_mail(record, :reset_password_instructions)
  end

end