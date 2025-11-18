class AnimalLogger
  def call(event)
    case event
    when AnimalBought
      Rails.logger.info "Animal bought: #{event.data[:name]} for $#{event.data[:price]}"
    when AnimalSold
      Rails.logger.info "Animal sold: #{event.data[:name]} for $#{event.data[:price]}"
    end
  end
end
