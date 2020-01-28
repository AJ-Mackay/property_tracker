require('pry')
require_relative('models/property')

Property.delete_all()

property1 = Property.new({
  "value" => "500000",
  "number_of_bedrooms" => "5",
  "year_built" => "1990",
  "buy_let_status" => "for sale"
  })

  property1.save()

property2 = Property.new({
  "value" => "200000",
  "number_of_bedrooms" => "2",
  "year_built" => "1970",
  "buy_let_status" => "for sale"
  })

  property2.save()

property3 = Property.new({
  "value" => "400000",
  "number_of_bedrooms" => "5",
  "year_built" => "2006",
  "buy_let_status" => "for let"
  })

  property3.save()

  binding.pry
  nil
