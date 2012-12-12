# /etc に存在するデータベースから情報を得るためのモジュール
# この場合は、ログインユーザー名を取得するために用いる
require "etc"

# 対象オブジェクト(subject)：本物のオブジェクト
# 銀行の入出金業務を行う
class BankAccount
  attr_reader :balance

  def initialize(balance)
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

# 代理サブジェクト(proxy)、ユーザーログインを担当する防御Proxy
class BankAccountProxy
  def initialize(real_object, owner_name)
    @real_object = real_object
    @owner_name = owner_name
  end

  # Rubyでは未定義のメソッド呼び出しが発生 => method_missingが呼び出される
  # method_missingを用いることでdeposit, withdrawを省略
  def method_missing(name, *args)
    check_access
    @real_object.send(name, *args)
  end

  def check_access
    if(Etc.getlogin != @owner_name)
      raise "Illegal access: #{@owner_name} cannot access account."
    end
  end
end
# ===========================================
account = BankAccount.new(100)
# login_userの部分はこの処理を行うMac/Linuxのログイン中のユーザー名に書き換えて下さい
proxy = BankAccountProxy.new(account, "login_user")
puts proxy.deposit(50)
puts proxy.withdraw(10)
# ログインユーザーの場合
#150
#140

account = BankAccount.new(100)
proxy = BankAccountProxy.new(account, "no_login_user")
puts proxy.deposit(50)
puts proxy.withdraw(10)
# ログインユーザーではない場合
#`check_access': Illegal access: no_login_user cannot access account. (RuntimeError)
#	from 08_proxy_sample1.rb:31:in `deposit'
#	from 08_proxy_sample1.rb:58:in `<main>'