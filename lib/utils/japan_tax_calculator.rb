class Utils::JapanTaxCalculator
  TAX_RATES        = { normal: 0.1, reduced: 0.08 }
  ROUNDING_METHODS = { round: :round, ceil: :ceil, floor: :floor }

  class << self
    def price_including_tax(price_excluding_tax, tax_rate: TAX_RATES[:normal], rounding_method: ROUNDING_METHODS[:ceil])
      (price_excluding_tax + price_excluding_tax * tax_rate).send(rounding_method)
    end
  end
end