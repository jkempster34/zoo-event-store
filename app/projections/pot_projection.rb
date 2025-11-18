class PotProjection
  def call
    balance = 0
    Rails.configuration.event_store.read.stream("zoo-accountancy").each do |event|
      case event
      when AnimalBought
        balance -= event.data[:price]
      when AnimalSold
        balance += event.data[:price]
      end
    end
    balance
  end
end
