# Targetにはないインターフェイスを持つ (Adaptee)
class OldPrinter
  def initialize(string)
    @string = string.dup
  end

  def show_with_bracket
    puts "[#{@string}]"
  end

  def show_with_asterisk
    puts "**#{@string}**"
  end
end

# 利用者(Client)へのインターフェイス (Target)
class Printer
  def initialize(obj)
    @obj = obj
  end

  def print_weak
    @obj.print_weak
  end

  def print_strong
    @obj.print_strong
  end
end

# textオブジェクト(OldPrinter)にAdapterの役割を持つ得意メソッドを追加
text = OldPrinter.new("Hello")
def text.print_weak
  show_with_bracket
end
def text.print_strong
  show_with_asterisk
end

# ===========================================
# 利用者(Client)
p = Printer.new(text)

p.print_weak
#=> [Hello]

p.print_strong
#=> **Hello**