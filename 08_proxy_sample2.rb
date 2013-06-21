# -*- coding: utf-8 -*-

# 銀行の入出金業務を行う(対象オブジェクト/subject)
class BankAccount
  attr_reader :balance

  def initialize(balance)
    puts "BankAccountを生成しました"
    @balance = balance
  end

  # 入金
  def deposit(amount)
    @balance += amount
  end

  # 出金
  def withdraw(amount)
    @balance -= amount
  end
end

# BankAccountの生成を遅らせる仮想Proxy
class VirtualAccountProxy
  def initialize(starting_balance)
    puts "VirtualAccountPoxyを生成しました。BankAccountはまだ生成していません。"
    @starting_balance = starting_balance
  end

  def balance
    subject.balance
  end

  def deposit(amount)
    subject.deposit(amount)
  end

  def withdraw(amount)
    subject.withdraw(amount)
  end

  def announce
    "Virtual Account Proxyが担当するアナウンスです"
  end

  def subject
    @subject || (@subject = BankAccount.new(@starting_balance))
  end
end

# ===========================================
proxy = VirtualAccountProxy.new(100)
#=> VirtualAccountPoxyを生成しました。BankAccountはまだ生成していません。

puts proxy.announce
#=> Virtual Account Proxyが担当するアナウンスです

puts proxy.deposit(50)
#=> BankAccountを生成しました
#=> 150

puts proxy.withdraw(10)
#=> 140