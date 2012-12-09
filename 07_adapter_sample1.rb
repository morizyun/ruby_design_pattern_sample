# アダプティ(Adaptee)
# Targetにはないインターフェイスを持つ
class OldTextObject
  def initialize(string)
    @string = string.dup
  end

  def show_with_paren
    puts "(#{@string})"
  end

  def show_with_aster
    puts "*#{@string}*"
  end
end

# ターゲット(Target)
# 実行対象
class TextObject
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

# アダプタ(Adapter)
# Targetが利用できるインターフェイスに変換
class OldTextObjectAdapter
  def initialize(string)
    @old_printer = OldTextObject.new(string)
  end

  def print_weak
    @old_printer.show_with_paren
  end

  def print_strong
    @old_printer.show_with_aster
  end
end

# ===========================================
# 利用者(Client)
p = TextObject.new(OldTextObjectAdapter.new("Hello"))
p.print_weak
p.print_strong
#(Hello)
#*Hello*