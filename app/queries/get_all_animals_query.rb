class GetAllAnimalsQuery < BaseQuery
  def call
    Animal.all
  end
end