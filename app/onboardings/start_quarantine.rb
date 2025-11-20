class StartQuarantine
  include ActiveModel::Model
  include ActiveModel::Attributes

  QuarantinedEvent = Data.define(:animal_unique_id, :onboarding_unique_id, :quarantine_started_at, :quarantine_location)

  attribute :quarantine_started_at, :datetime
  attribute :onboarding_id
  attribute :quarantine_location, :string

  validate :quarantine_started_at_after_received_at
  validates_presence_of :quarantine_location

  def run!
    return false if invalid?
    events = []

    events << QuarantinedEvent.new(quarantine_started_at:, quarantine_location:, onboarding_unique_id: @onboarding.unique_id, animal_unique_id: @onboarding.animal.unique_id)

    ActiveRecord::Base.transaction do
      events.each do |event|
        handle_event(event:, onboarding:)
      end
    end
  end


  def onboarding
    @onboarding ||= Onboarding.find_by!(unique_id: onboarding_id)
  end

  def handle_event(event:, onboarding:)
    case event
    when QuarantinedEvent
      onboarding.quarantine_started_at = event.quarantine_started_at
      onboarding.quarantine_location = event.quarantine_location

      onboarding.save!
    end

    Event.create!(type: event.class.name, data: event.to_h)
  end

  def quarantine_started_at_after_received_at
    unless quarantine_started_at > onboarding.date_received
      errors.add(:quarantine_started_at, message: 'must be after received at')
    end
  end
end