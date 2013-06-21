# -*- coding: utf-8 -*-

# 銀行口座を表す
class Account
  attr_accessor :name, :balance

  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def <=>(other)
    @balance <=> other.balance
  end
end

# 有価証券のセットを表す
class Portfolio
  include Enumerable

  def initialize
    @accounts = []
  end

  def each(&block)
    @accounts.each(&block)
  end

  def add_account(account)
    @accounts << account
  end
end

# ===========================================
portfolio = Portfolio.new
portfolio.add_account(Account.new("account1", 1000))
portfolio.add_account(Account.new("account2", 2000))
portfolio.add_account(Account.new("account3", 3000))
portfolio.add_account(Account.new("account4", 4000))
portfolio.add_account(Account.new("account5", 5000))

# $3000より多く所有している口座があるか？
puts portfolio.any? { |account| account.balance > 3000 }
#=> true

# すべての口座が$2000以上あるか？
puts portfolio.all? { |account| account.balance >= 2000 }
#=> false