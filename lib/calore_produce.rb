# frozen_string_literal: true

require_relative "calore_produce/version"

module CaloreProduce
  class << self
    def hello
      puts "Hello, Cal-Ore Produce. #{CaloreProduceVersion::VERSION}"
    end

    def number_with_precision(number = 0, precision = 0)
      sprintf("%0.#{precision}f", number).gsub(/(\d)(?=(\d{3})+(?!\d))/, "\\1,")
    end

    def number_to_currency(number = 0, precision = 2)
      sprintf("$%0.#{precision}f", number).reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end

    def set_precision_with_code(number = 0, product_code = 'C')
      product_code_to_weight =  self.product_code_to_weight
      if product_code_to_weight.present?
          precision = product_code_to_weight[product_code].to_i == 100 ? 2: 0
      else
          precision = 2
      end
      self.number_with_precision(number, precision)
    end

    def product_code_to_weight
      Product.pluck(:product_code, :weight).map { |k, v| [k, v] }.to_h
    end
  end

end
