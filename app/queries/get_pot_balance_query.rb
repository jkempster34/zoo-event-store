class GetPotBalanceQuery < BaseQuery
  def call
    PotProjection.new.call
  end
end