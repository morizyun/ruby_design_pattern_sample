class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = 'report title'
    @text = %w(text1 text2 text3)
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(self)
  end
end

class Formatter
  def output_report(title, text)
    raise 'Called abstract method !!'
  end
end

class HTMLFormatter < Formatter
  def output_report(report)
    puts "<html><head><title>#{report.title}</title></head><body>"
    report.text.each { |line| puts "<p>#{line}</p>" }
    puts '</body></html>'
  end
end

class PlaneTextFormatter < Formatter
  def output_report(report)
    puts "***** #{report.title} *****"
    report.text.each { |line| puts(line) }
  end
end

# ===========================================
report = Report.new(HTMLFormatter.new)
report.output_report
#<html><head><title>report title</title></head><body>
#<p>text1</p>
#<p>text2</p>
#<p>text3</p>
#</body></html>

report.formatter = PlaneTextFormatter.new
report.output_report
#***** report title *****
#text1
#text2
#text3