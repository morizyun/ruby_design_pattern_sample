# -*- coding: utf-8 -*-

# Singletonは、Mix-inしたクラスのinstanceは同一のインスタンスを返すようになる
# Singletonを実装した場合は#cloneができない
require 'singleton'

# シングルトン
class SingletonObject
  # instanceメソッドが定義され、newメソッドがprivateに設定される
  include Singleton
  attr_accessor :counter

  def initialize
    @counter = 0
  end
end

# ===========================================
obj1 = SingletonObject.instance
obj1.counter += 1
puts(obj1.counter)
# 1

obj2 = SingletonObject.instance
obj2.counter += 1
puts(obj2.counter)
# 2
# ↑ 前回の+1が引き継がれている

obj3 = SingletonObject.new
# private method `new' called for SingletonObject:Class (NoMethodError)
# ↑ newでのインスタンスの作成に失敗