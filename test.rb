require 'awesome_print'
require 'mercurypay'

client = MercuryPay.new '023358150511666', 'xyz'

input = {card_number: 5499990123456781, cvc: 123, expir_month: 8, expir_year: 2016}

ap "Validate Card"
ap "Input: "
ap input
res = client.validate_card(input)
ap "Output: "
ap res

token = res[:RecordNo]

input = {card_number: 5499990123456781, cvc: 123, expir_month: 8, expir_year: 2016, amount: 6.64, invoice_id: '214DDAS31'}

ap "Charge With Card"
ap "Input: "
ap input
res = client.charge_with_card(input)
ap "Output: "
ap res

# input = {token: res[:RecordNo], amount: 6.64, invoice_id: '214DDAS31'}
input = {token: "NQSqW3wORRaLD8AIk7FFjXGGcEdsicxD68dO5yyFMHkiEgUQCSIQCJYd", amount: 6.64, invoice_id: '214DDAS31'}

ap "Charge With Token"
ap "Input: "
ap input
res = client.charge_with_token(input)
ap "Output: "
ap res