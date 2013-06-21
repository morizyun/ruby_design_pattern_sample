# -*- coding: utf-8 -*-
require 'observer'

# 従業員を表す
class Employee
  include Observable # Observerとして働く

  attr_reader :name, :title, :salary

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    add_observer(Payroll.new)
    add_observer(TaxMan.new)
  end

  # 給与をセットして、ConcreteObserverに通知する
  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end
end

# 給与の小切手の発行を行う(ConcreteObserver)
class Payroll
  def update(changed_employee)
    puts "彼の給料は#{changed_employee.salary}になりました！#{changed_employee.title}のために新しい小切手を切ります。"
  end
end

# 税金の請求書の発行を行う(ConcreteObserver)
class TaxMan
  def update(changed_employee)
    puts "#{changed_employee.name}に新しい税金の請求書を送ります。"
  end
end

# ===========================================
john = Employee.new('John', 'Senior Vice President', 5000)
john.salary = 6000
#=> 彼の給料は6000になりました！Senior Vice Presidentのために新しい小切手を切ります。
#=> Johnに新しい税金の請求書を送ります。
john.salary = 7000
#=> 彼の給料は7000になりました！Senior Vice Presidentのために新しい小切手を切ります。
#=> Johnに新しい税金の請求書を送ります。