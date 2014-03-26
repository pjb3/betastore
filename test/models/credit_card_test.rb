require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase

  def test_save_success
    credit_card = customers(:paul).credit_cards.build(card_number: '4111111111111111', expiration_date: '03/2017')
    assert credit_card.save,
      credit_card.errors.full_messages.join(', ')
  end

  def test_save_no_card_number
    credit_card = customers(:paul).credit_cards.build(expiration_date: '03/2017')
    refute credit_card.save
    assert_equal ["can't be blank"],
      credit_card.errors[:card_number]
  end

  def test_save_invalid_card_number
    credit_card = customers(:paul).credit_cards.build(card_number: '4111', expiration_date: '03/2017')
    refute credit_card.save
    assert_equal ["is invalid"],
      credit_card.errors[:card_number]
  end

  def test_save_no_expiration_date
    credit_card = customers(:paul).credit_cards.build(card_number: '4111111111111111')
    refute credit_card.save
    assert_equal ["is required"],
      credit_card.errors[:expiration_date]
  end

  def test_save_invalid_expiration_date
    credit_card = customers(:paul).credit_cards.build(card_number: '4111111111111111', expiration_date: '3/17')
    refute credit_card.save
    assert_equal ["should be in the format MM/YYYY"],
      credit_card.errors[:expiration_date]
  end

  def test_save_expired
    credit_card = customers(:paul).credit_cards.build(card_number: '4111111111111111', expiration_date: '01/2013')
    refute credit_card.save
    assert_equal ["has expired"],
      credit_card.errors[:expiration_date]
  end

end
