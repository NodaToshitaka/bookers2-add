class GroupMailer < ApplicationMailer
  def send_notification(menber, event)
    @group = event[:group]
    @title = event[:title]
    @body = event[:body]

    @mail = GroupMailer.new
    mail(
      form: EVN['MAIL_ADDRESS'],
      to: menber.email,
      subject: 'New Event Notice!!'
    )
  end
  
  def self.send_notifications_to_group(event)
    group = event[:group]
    group.users.each do |member|
      EventMailer.send_notification(member, event).deliver_now
    end
  end
end
