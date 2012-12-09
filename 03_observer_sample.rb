# -*- coding: utf-8 -*-
require 'observer'
class Employee
  include Observable

  attr_reader :name, :address, :salary

  def initialize(name, title, salary)
    @title = name
    @title = title
    @salary = salary
    add_observer(Payroll.new)
    add_observer(TaxMan.new)
  end

  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end
end

class Payroll
  def update(changed_employee)
    puts "彼の給料は#{changed_employee.salary}になりました！#{changed_employee.title}のために新しい小切手を切ります。"
  end
end

class TaxMan
  def update(changed_employee)
    puts "#{changed_employee.title}に新しい税金の請求書を送ります"
  end
end

# ===========================================
john = Employee.new('John', 'Senior Vice President', 5000)
john.salary = 6000
john.salary = 7000
#彼の給料は6000になりました！Johnのために新しい小切手を切ります。
#Johnに新しい税金の請求書を送ります
#彼の給料は7000になりました！Johnのために新しい小切手を切ります。
#Johnに新しい税金の請求書を送ります