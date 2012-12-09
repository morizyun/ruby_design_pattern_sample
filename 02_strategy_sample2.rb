class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = 'report title'
    @text = %w(text1 text2 text3)
    @formatter = formatter
  end

  def output_report
    @formatter.call(self)
  end
end

HTML_FORMATTER = lambda do |context|
  puts "<html><head><title>#{context.title}</title></head><body>"
  context.text.each { |line| puts "<p>#{line}</p>" }
  puts '</body></html>'
end

PLANE_TEXT_FORMATTER = lambda do |context|
  puts "***** #{context.title} *****"
  context.text.each { |line| puts(line) }
end

# ===========================================
report = Report.new(&HTML_FORMATTER)
report.output_report
#<html><head><title>report title</title></head><body>
#<p>text1</p>
#<p>text2</p>
#<p>text3</p>
#</body></html>

report.formatter = PLANE_TEXT_FORMATTER
report.output_report
#***** report title *****
#text1
#text2
#text3