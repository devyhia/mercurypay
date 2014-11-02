require "mercurypay/version"
require 'httparty'

class MercuryPay
	include HTTParty
	base_uri 'https://w1.mercurycert.net/PaymentsAPI/Credit'

	def initialize(merchant_id, password)
		self.class.basic_auth merchant_id, password
	end

	# options = {
	# 	card_number: 5499990123456781,
	# 	cvc: 123,
	# 	expir_month: 8,
	# 	expir_year: 2016,
	#   amount: 5.55,
	#   invoice_id: "214dsfav331"
	# }
	def charge_with_card(options)
		res = self.class.post("/Sale", body: {
			:InvoiceNo=> options[:invoice_id],
			:RecordNo=> "RecordNumberRequested",
			:Frequency=> "OneTime", # OneTime or Recurring
			:AcctNo=> options[:card_number].to_s,
			:ExpDate=> options[:expir_month].to_s.rjust(2, "0")+options[:expir_year].to_s[2..3],
			:Purchase=>options[:amount].to_s,
			:CVVData=> options[:cvc].to_s,
			:OperatorID=> "money2020"
		})

		response = parse_response res
	end

	# options = {
	# 	token: '',
	#   amount: 5.55,
	#   invoice_id: "214dsfav331"
	# }
	def charge_with_token(options)
		res = self.class.post("/SaleByRecordNo", body: {
			:InvoiceNo=> options[:invoice_id],
			:RecordNo=> options[:token],
			:Frequency=> "OneTime", # OneTime or Recurring
			:Purchase=>options[:amount].to_s,
			:OperatorID=> "money2020"
		})

		response = parse_response res
	end

	# options = {
	# 	card_number: 5499990123456781,
	# 	cvc: 123,
	# 	expir_month: 8,
	# 	expir_year: 2016
	# }
	# Response: CmdStatus ::= Approved | Declined | Error
	def validate_card(options)
		res = self.class.post("/ZeroAuth", body: {
			:InvoiceNo=> "1",
			:RecordNo=> "RecordNumberRequested",
			:Frequency=> "OneTime", # OneTime or Recurring
			:AcctNo=> options[:card_number].to_s,
			:ExpDate=> options[:expir_month].to_s.rjust(2, "0")+options[:expir_year].to_s[2..3],
			# "Purchase":"1.00",
			:CVVData=> options[:cvc].to_s,
			:OperatorID=> "money2020"
		})

		response = parse_response res
	end

	private
	def parse_response(res)
		temp_hash = {}
		res.body.split('&').each { |i| temp_hash[i.split('=')[0].to_sym] = i.split('=')[1] }
		return temp_hash
	end
end