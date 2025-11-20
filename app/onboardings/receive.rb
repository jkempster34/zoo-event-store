class Receive
  ## Hybrid approach - We're creating and persisting events, but not "hydrating" them to infer
  # state. Instead, we're just saving state on the records. But, the events provide us
  # with an audit log, and they drive our decision making.
  include ActiveModel::Model
  include ActiveModel::Attributes

  ReceivedEvent = Data.define(:animal_unique_id, :onboarding_unique_id, :date_received, :name, :species)
  NoCitesCertificateEvent = Data.define(:animal_unique_id, :onboarding_unique_id)

  attribute :cites_certificate_present, :boolean
  attribute :species, :string
  attribute :name, :string
  attribute :date_received, :date

  validates_presence_of :species

  attr_reader :onboarding_id

  def run!
    return false if invalid?

    animal_id = SecureRandom.uuid
    @onboarding_id = SecureRandom.uuid
    animal = Animal.new(unique_id: animal_id)
    onboarding = Onboarding.new(unique_id: onboarding_id, animal: animal)

    events = []
    events << ReceivedEvent.new(animal_unique_id: animal_id, onboarding_unique_id: onboarding_id, date_received:, name:, species:)
    unless cites_certificate_present
      events << NoCitesCertificateEvent.new(animal_unique_id: animal_id, onboarding_unique_id: onboarding_id)
    end

    ActiveRecord::Base.transaction do
      events.each do |event|
        handle_event(event:, animal:, onboarding:)
      end
    end
  end

  def persisted?
    false
  end

  def handle_event(event:, animal:, onboarding:)
    case event
    when ReceivedEvent
      # assigning properties from the event, so that the event and onboarding/animal record are in sync
      onboarding.date_received = event.date_received
      animal.name = event.name
      animal.species = event.species
      onboarding.animal = animal
      onboarding.status = :received
      onboarding.save!
    when NoCitesCertificateEvent
      onboarding.cites_certificate_present = false
      onboarding.save!
    end

    Event.create!(type: event.class.name, data: event.to_h)
  end
end