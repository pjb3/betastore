class CreditCard < ActiveRecord::Base
  belongs_to :customer

  def expiry=(expiry)
    self.expires_on = Date.strptime(expiry, '%m/%y') + 1.month
  end
end
